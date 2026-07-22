# LINE WORKS タスク割り当てMCPサーバー 要件定義書

`LINE_WORKS_MCP_SERVER_PLAN.md`の実運用版。看護部長が自然言語で部下にLINE WORKSタスクを割り当てられるようにする、常時稼働型のMCPサーバー。

新規リポジトリで開発する前提の要件文書。

---

## 1. 背景・目的

- 看護部長が、Claude(または他のMCP対応クライアント)経由で「Aさんに明日までにこのタスクをお願い」のように自然言語で依頼するだけで、LINE WORKS上に実際のタスクが作成される仕組みを作る
- 既存の`LINE_TASK_CONTROL`リポジトリにAPI連携ロジックの土台があるが、**このリポジトリはREADME本文に実際のClient ID/Client Secret/サービスアカウントIDが平文で残っており、現時点で情報漏えいが発生している**。新規リポジトリでは、このコード資産をロジックとしてのみ参考にし、認証情報は一切引き継がない

## 2. 前提として必須の対応(実装着手前)

- [ ] `LINE_TASK_CONTROL`のREADMEに記載されている既存のClient ID/Client Secret/サービスアカウントを、LINE WORKS Developer Consoleで失効・再発行する
- [ ] このタスク管理MCP専用に、**新しいService Account(Bot)**をLINE WORKS Developer Consoleで発行する(既存の`LINE_TASK_CONTROL`用とは別物)
- [ ] 新しいClient ID/Client Secret/秘密鍵は、新リポジトリのコード・READMEに一切書かない。Secret Manager(GCP)またはCloud Runの環境変数(Secret参照)のみで管理する

## 3. 決定済みの設計方針

| 論点 | 決定 |
|---|---|
| タスク作成の認証主体 | 専用のBot(サービスアカウント)経由。看護部長個人のアカウント認証は使わない |
| 実行環境 | 常時稼働のサーバー(Cloud Run等)。ローカルのstdio型MCPではない |
| タスクの「作成者」表示 | LINE WORKS上では看護部長が作成したタスクとして見えるようにする(API呼び出し自体はBotの認証情報で行うが、タスクのauthor/ownerには看護部長のuserIdを指定する) |

## 4. 機能要件(MVPスコープ、ツールは絞る)

### ツール1: `create_task`
- **入力**: 担当者のメールアドレス(または氏名)、タスク内容、期限(任意, YYYY-MM-DD)
- **処理**: 担当者のメールアドレスからuserIdを検索 → LINE WORKS Task API (`POST /users/{authorId}/tasks`) を呼び出し、`authorId`は看護部長のuserId固定、`assignees`に担当者のuserIdを設定
- **出力**: 作成されたタスクID・LINE WORKS上のURL
- **エラー処理**: 担当者が見つからない場合は明確なエラーメッセージを返し、タスクは作成しない(自分宛にフォールバックしない — 既存コードの`post_task.py`はフォールバックしているが、誤送信防止のため新版では禁止する)

### ツール2: `list_subordinates`
- **入力**: 部署名(任意、部分一致フィルタ)
- **処理**: LINE WORKS User API (`GET /users`) で組織内ユーザー一覧を取得し、部署でフィルタ
- **出力**: 氏名・メールアドレス・部署のリスト(userIdは内部処理用でツール応答には含めない方が安全)

### (将来検討・MVP対象外)
- タスク一覧取得・ステータス確認ツール: LINE WORKS APIの該当エンドポイント仕様が本ドキュメント作成時点で未確認のため、MVPには含めない。必要になった時点でAPI仕様を確認の上、別途要件化する

## 5. 非機能要件

### 認証・認可(MCPサーバー自体への接続)
- Cloud Run上の常時稼働サービスとして外部からアクセス可能になるため、MCPエンドポイント自体に認証を必須とする
- 最小構成として、固定のBearerトークン(共有シークレット)を`Authorization`ヘッダーで要求し、看護部長のMCPクライアント設定にのみそのトークンを登録する
- 将来的に利用者が増える場合はOAuthベースの認証への移行を検討する

### LINE WORKS API認証
- サービスアカウントのJWTアサーション(RS256署名)による認証(既存の`get_key.py`のロジックを踏襲)
- 常時稼働サーバーのため、アクセストークンをファイル保存(`tokens.json`)する方式ではなく、有効期限を見てオンデマンドで再発行するインメモリキャッシュ方式にする

### 監査ログ
- `create_task`が呼ばれるたびに「いつ・誰が・誰に・どんな内容のタスクを作成したか」をログ出力する(Cloud Run標準ログで十分。個人の詳細な行動ログを別DBに永続化する必要は現時点ではない)

### 入力バリデーション
- タスク内容が空でないこと
- メールアドレス形式の簡易チェック
- 該当ユーザーが見つからない場合はタスクを作成せずエラーを返す(誤送信防止)

### シークレット管理
- Client Secret・秘密鍵はコード・README・.envファイルのいずれにもコミットしない
- `.gitignore`で`.env`・`*.pem`・`tokens.json`を除外(既存リポジトリの設定を踏襲)
- GCP Secret Managerに格納し、Cloud Runの実行時に環境変数として注入する

## 6. 技術スタック

- 言語: Python
- MCPサーバー実装: MCP Python SDK(`FastMCP`、Streamable HTTP transport)
- LINE WORKS API連携: `requests` + `PyJWT`(既存コード資産を流用)
- デプロイ: Docker + Cloud Run
- シークレット管理: GCP Secret Manager

## 7. リポジトリ構成案

```
line-works-task-mcp/
  app/
    server.py            # MCPサーバー本体(create_task, list_subordinatesを公開)
    line_works_client.py # LINE WORKS API呼び出し(トークン取得込み)
    auth.py               # MCPエンドポイント自体のBearerトークン検証
    config.py             # 環境変数からの設定読み込み
  Dockerfile
  requirements.txt
  .env.example            # キーは空、変数名のみ記載
  .gitignore
  README.md
```

## 8. 受け入れ基準(Definition of Done)

- [ ] 新しいService Account(既存とは別物)で認証が通る
- [ ] `create_task`で指定した担当者宛にLINE WORKS上で実際にタスクが作成されることを確認
- [ ] 存在しないメールアドレスを指定した場合、タスクが作成されずエラーが返ることを確認
- [ ] `list_subordinates`で部署フィルタが正しく機能することを確認
- [ ] MCPエンドポイントに正しいBearerトークンなしでアクセスした場合、拒否されることを確認
- [ ] リポジトリ内にClient Secret・秘密鍵・実際のuserId/メールアドレスが一切コミットされていないことを確認(コミット前にレビュー)
- [ ] Cloud Run上で常時稼働し、看護部長のMCPクライアントから接続できることを確認
