# 技術スタック・キャリアロードマップ

> **最終評価: 2026-11-22** ｜ 次回レビュー目安: 2026-02（四半期ごと）
> 対象スコープ: 所有リポジトリ 65件 ＋ はとがや病院グループ（collaborator / `hatogayait-AX` 他）35件

自分の年収・市場価値を上げる観点から、リポジトリ群の棚卸しを踏まえて整理した技術スタック面の優先課題と、¥1億円を狙う長期ルート。
**このドキュメントは四半期ごとに「進捗スナップショット」と「更新履歴」を更新して運用する。** 更新手順は末尾の「レビュー手順」を参照。

---

## 📋 進捗スナップショット（2026-11-22）

| # | テーマ | 計画(2026-07) | 現状 | 判定 | 次の一手 |
|---|--------|--------------|------|:----:|---------|
| ① | RAG→エージェント/MCP基盤 | 最後回し | MCPサーバー5〜6本稼働・LINE WORKS MCP実装済み | 🟢達成 | 英語README化・OSS公開 |
| ② | シークレット管理の型化 | **最優先** | gitleaks/pre-commit 未導入のまま | 🔴未着手 | 全repoへgitleaks展開（最優先・最短） |
| ③ | 個別Firebase→共通プラットフォーム | 中 | `hatogaya-data-hub-product` MVP着手 | 🟡進行中 | テナント設計を明文化・"見せ札"化 |
| ④ | スクリプト集→データパイプライン | 中 | `Data_etl_task` でETL化の初手 | 🟡一部 | dbt + BigQuery スケジュールELTへ |
| ⑤ | 生成AIにeval/ガードレール | 2番目 | 専用基盤なし | 🔴未着手 | eval型を1本切り出す |

判定凡例: 🟢達成 / 🟡進行中 / 🔴未着手

**今期の結論:** ①は計画を追い越して達成。**②が最大の未解決点（4ヶ月放置・最短最高レバレッジ）。** 実際の行動はルートA（AI基盤）側へ蓄積が進む一方、ルートBは土台を再建フェーズへ切り替える必要がある（後述）。

---

## パートI: 社内評価・年収向上（①〜⑤）

優先度の現実解: **② → ⑤ → ③ → ④ → ①（①は維持・発信フェーズ）**

### ① RAG止まりを「エージェント基盤」に進化させる — 🟢 ほぼ達成

計画時は「GAS上の素朴なRAG実装に留まる」状態だったが、現在は MCP ベースへ移行済み。
- `line-works-mcp-server` — LINE WORKS を MCP化（メッセージ送信・ユーザー一覧・タスク作成・トーク要約）。**①が狙った構成そのもの。**
- `Claude_base_spread_sheet_ppt_google_doc_MCP` — Google Sheets/Docs/Slides 直書き MCP（10ツール稼働中）
- `ekispert-multimodal-mcp-product`（Agentic AI Hackathon Vol.5）・`Google_mail_mcp`・`LINE_message_MCP_Product`・`Claude_base_html_make_MCP`

→ 次は「作れる」から「公開して認知される」へ。業務データを除いた**汎用設計を英語READMEでOSS公開**する（ルートAの入口も兼ねる）。

### ② シークレット管理を「型」にする — 🔴 最優先・未着手（最大レバレッジ）

棚卸しで複数リポジトリにAPIキー直書きを確認したが、2026-11時点でも `Firebase_Hatogaya_voice_product` / `hatogaya_jotform_product` / `YRC-shukatsu-lab` / `git_control` のいずれにも gitleaks・pre-commit 設定が**無い**。
市場価値を測る側（LAPRAS/採用担当/松本さん）が最初に見る「基礎体力」であり、**1日で終わるのに放置コストが最も高い。** 具体策:
1. `git_control` に gitleaks の GitHub Actions を置き、全リポジトリへ横展開
2. `.pre-commit-config.yaml` をテンプレ化して各repoへ配布
3. 既に直書きされたキーはローテーション＋Secret Manager(GCP)/環境変数へ移設

### ③ 個別Firebaseの乱立を「共通プラットフォーム」化する — 🟡 進行中

`negishi_survey` と `azuma-jotform` の同型テンプレ複製に対し、[hatogaya-data-hub-product](https://github.com/hatogayait-AX/hatogaya-data-hub-product)（シフトマネージャー/jinjer/タレントマネジメント間のデータ連携を集約する統合ハブ・MVP）が**プラットフォーム設計への転換点**として既に動いている。はとがや系が `hatogayait-AX` org に集約された事実自体も組織的プラットフォーム化のシグナル。
→ 「テナント切り替え可能な共通コードベース」としての設計を明文化し、昇給・昇格で一番効く**「再利用性・スケーラビリティ」の実例**として提示する。

### ④ pandasスクリプト集を「データパイプライン」に格上げする — 🟡 一部着手

[Data_etl_task](https://github.com/SOOJUNBARNG/Data_etl_task)（会計データの構造化ETL）で「スクリプト集→パイプライン」の初手は踏んだが、まだ「Pythonスクリプト4本」。`data_visualization_task`・`GCP_IAM_COST_CONTROL` も単体スクリプト止まり。
→ dbt + BigQuery のスケジュールELT、最低限 Airflow/Cloud Composer のオーケストレーションへ。「アドホック分析ができる人」→「データ基盤を運用できる人」。

### ⑤ 生成AIチャットボットに評価・ガードレールを入れる — 🔴 未着手

患者・職員向けチャットボット（LINE/LINE WORKS系）のプロンプト評価(eval)・誤回答防止ガードレールが未整備。
→ eval を型化した小さなリポジトリを1本切り出す。「生成AIを繋いだ人」→「生成AIを安全に本番運用できる人」。市場で最も評価される立ち位置。

---

## パートII: ¥1億円ルート — 二本柱で並走（A・B両方を本気で維持）

日本の一般給与レンジの外側のため、①〜⑤（社内評価）とは別軸。**金融（B）は諦めない。** ただし純クオンツの土台だった `StockSharp_barng` はGitHub上で消滅（404）しているため、Bは「再建フェーズ」として正式に扱う。

### ⚠️ 2026-11 時点の重要な状態変化
- `StockSharp_barng`（低レイテンシ取引の土台）→ **GitHub上404。** ローカル/別管理なら復活、無ければ新規土台を立てる。
- `Barng_financial_projects`（AIヘッジファンドPOC）→ 2026-07-18から更新停止。
- 一方、**AI×金融/会計データの実資産は10本**存在（下記B1）。金融軸はゼロではない。

### ルートA: フロンティアAIラボ向け「エージェント/AI基盤エンジニア」

OpenAI/Anthropic/Google DeepMind 等が実際に支払う層。研究者(PhD必須)ではなく、エージェント基盤・評価基盤・学習インフラを作るエンジニア。**この4ヶ月で素材が自然に蓄積した（計画外の追い風）。**
- 分散学習・推論基盤: PyTorch/JAX、マルチGPU/TPU（Ray, vLLM, SGLang）
  - 実績: `Make_music_product`(ACE-Step/L4 GPU)、`Make_image_product`(Pony Diffusion XL/T4)、`Write_novel_product`(Qwen2.5-7B 1M context)
- **モデル蒸留**: [Hatogaya_SLM_product](https://github.com/hatogayait-AX/Hatogaya_SLM_product)（TinySwallow×BioMistral 蒸留・Ollama・完全オフライン）← ルートAの中核スキルが既に手元にある
- エージェント評価基盤: LLM eval 自作、ベンチマーク設計、RLHF/RLAIF 理解（⑤と接続）
- MCP/ツール実行基盤: 既存MCP群の延長で、サンドボックス・権限制御・並列実行まで
- 英語での発信: 英語README・OSS貢献(vLLM, LangChain, LlamaIndex等)が採用の入口
- 前提: 国内給与テーブルでは到達しないため、リモートで海外(米国)企業に直接雇用される必要

### ルートB: 金融 — 二層構造で維持（**諦めない**）

#### B1. AI×金融/会計データ基盤（🟢 既に進行中・ここが現実的な稼ぎ頭）
純クオンツより先に、既存資産で「AI×金融データエンジニア」として積み上げられる。他候補にない具体的強み。
- 実資産: `Data_etl_task`(会計ETL)、`MF_API_task`(マネーフォワードAPI)、`OCR_based_financial_data_analysis_task`(請求書OCR)、`Data_for_receipt`(レセプト経営分析)、`Financial_evaluation_task_tool`(PL/BS評価)、`Barng_financial_projects`(AIヘッジファンドPOC)
- 次の一手: これらを「金融データ基盤」として1つの文脈に束ね、再利用可能なパイプライン＋ダッシュボードとして見せる（③④と接続）

#### B2. 低レイテンシ/システムトレーディング（🔴 土台再建フェーズ）
成果報酬で¥1億に届く構造。ただし土台(StockSharp)が消えたため**まず土台の再確定から**。
- 低レイテンシ: C++（またはRust）、メモリ管理、ロックフリーデータ構造
- 統計・数理: 時系列解析、確率過程、ポートフォリオ最適化（現状のOR-Tools知見が活きる）
- バックテスト基盤: 自作エンジン。**検証可能な戦略を1つ、最後まで作り切る**
- 市場データ: ティックデータのストリーム処理(Kafka, ClickHouse等)
- 出口: 東京拠点の外資系プロップ/ヘッジファンド(Citadel, Jane Street, Optiver, IMC等)の**クオンツデベロッパー職（開発職）**
- ⚠️ 自己資金での実運用は個人の金融リスク判断。本ロードマップはスキル・ポートフォリオ・雇用可能性の観点に限定する。

### 時間配分の考え方（現実データに合わせて更新）

計画(2026-07)は「B本流80% / A副業20%」だったが、実際の手の動きはA寄り。**どちらも諦めないため、以下に再編:**

| トラック | 位置づけ | 目安配分 | 今期の最優先タスク |
|---------|---------|:------:|------------------|
| **A: AI基盤** | 近期の複利（モメンタムあり） | 40% | MCP設計を英語OSS公開1本 |
| **B1: AI×金融データ** | 金融軸の現実的な本流 | 40% | 既存10資産を"金融データ基盤"に束ねる |
| **B2: 低レイテンシ取引** | 長期アンカー（土台再建） | 20% | StockSharp相当の土台を再確定し戦略1本に着手 |

> B2を薄く長く維持することで「金融マン」の軸は手放さない。B1で金融の実績を積みながら、A/③④で基盤力を上げ、B2はバックテスト土台が再建でき次第ギアを上げる。

---

## 🔁 レビュー手順（四半期ごと・このドキュメントの更新方法）

1. 最新のリポジトリ状況を取得:
   ```bash
   gh repo list SOOJUNBARNG --limit 100 --json name,description,updatedAt --jq 'sort_by(.updatedAt)|reverse|.[]|"\(.updatedAt[:10]) \(.name) — \(.description // "—")"'
   ```
2. ①〜⑤ の「現状」「判定」を上の進捗スナップショット表で更新（🔴→🟡→🟢）
3. ②シークレット管理の進捗を機械チェック:
   ```bash
   for r in <対象repo>; do gh api repos/<owner>/$r/contents --jq '.[].name' | grep -iE 'gitleaks|pre-commit' && echo "$r: OK" || echo "$r: 未導入"; done
   ```
4. B2の土台(StockSharp相当)が復活/再建されたかを確認
5. 「時間配分」表を実際の更新頻度に合わせて見直す
6. 下の更新履歴に1行追記

---

## 🗒️ 更新履歴

| 日付 | 変更点 |
|------|--------|
| 2026-11-22 | 全面改訂。①達成・②未着手・③④進行中を反映。`StockSharp_barng`消滅を受けルートBをB1(AI×金融データ)/B2(低レイテンシ取引・土台再建)の二層に再編。四半期レビュー機構を追加。 |
| 2026-07-22 | 初版（リポジトリ57件時点）。①〜⑤とルートA/Bを整理。 |
