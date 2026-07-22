# AX(AI-Transformation)棚卸しレポート

**対象**: SOOJUNBARNG名義 全57リポジトリ
**作成日**: 2026-07-22
**用途**: 2026-08-06 経営会議(松本さん)向け、補助金申請関連AX施策の説明資料

> ⚠️ 数値・KPI・ROIの列はすべて **未入力(要記入)** です。READMEからは実際の削減時間・コスト・投資額を把握できないため、現場の実績値やヒアリングに基づいて記入してください。

---

## 目次

1. [ROI集計表(数値要入力)](#roi集計表数値要入力)
2. [Hatogaya系](#1-hatogaya系鳩ヶ谷病院関連)
3. [Negishi系](#2-negishi系老健ねぎしケアセンター)
4. [Azuma系](#3-azuma系あずま在宅クリニック)
5. [Tokiwa/THS系](#4-tokiwa--ths系)
6. [全社共通ツール系](#5-全社共通ツール系)
7. [LINE・コミュニケーション系](#6-lineコミュニケーション系)
8. [データ分析・可視化系](#7-データ分析可視化系)
9. [M&A・その他](#8-ma・その他)
10. [判断が分かれるもの](#9-判断が分かれるもの)
11. [情報不足のもの](#10-readme情報不足で判断できなかったもの)
12. [補足・注意事項](#補足注意事項)

---

## ROI集計表(数値要入力)

| 施策名 | カテゴリ | 稼働状況 | 現状の手作業時間(h/月) | 自動化後の時間(h/月) | 削減時間(h/月) | 削減額換算(円/月) | 開発・運用コスト(円) | ROI(倍) |
|---|---|---|---|---|---|---|---|---|
| Hatogaya_shift_automation_app | Hatogaya | 稼働中 | | | | | | |
| Hatogaya_talent_management | Hatogaya | | | | | | | |
| Job_quit | Hatogaya | 稼働中(hatogaya-job-quit.web.app) | | | | | | |
| Data_for_receipt | Hatogaya | 稼働中(Cloud Run) | | | | | | |
| Scrap_medical_job_detail_task | Hatogaya | | | | | | | |
| Firebase_Hatogaya_voice | Hatogaya | 検証中 | | | | | | |
| Negishi_homecare_HP | Negishi | 稼働中 | | | | | | |
| negishi_survey | Negishi | 稼働中 | | | | | | |
| azuma-jotform | Azuma | 稼働中 | | | | | | |
| azuma-visit-clinic-hp | Azuma | 稼働中 | | | | | | |
| Tokiwa-healthcare-service | Tokiwa | 稼働中 | | | | | | |
| THS_dentist_shift_automake_data | Tokiwa/THS | 要件定義段階 | | | | | | |
| GCP_IAM_COST_CONTROL | 全社共通 | | | | | | | |
| Google_ads_control | 全社共通 | | | | | | | |
| Google_drive_file_directory_change | 全社共通 | | | | | | | |
| KJM_GAS_electricity_water_result_task | 全社共通 | 稼働中 | | | | | | |
| Auto-translation-task | 全社共通 | | | | | | | |
| auto_contact_form_task | 全社共通 | | | | | | | |
| google-maps-route-optimizer | 全社共通 | | | | | | | |
| image_bg_task | 全社共通 | | | | | | | |
| Data_upload_and_download | 全社共通 | 未完成部分あり | | | | | | |
| LINE_WORKS_SUMMARY | LINE系 | 稼働中 | | | | | | |
| LINE_LINEWORKS_GAS_SERVER_AI_CHATSERVICE | LINE系 | 稼働中(複数URL) | | | | | | |
| LINE_TASK_CONTROL | LINE系 | | | | | | | |
| AI_Voice_bot_netlify | LINE系 | 初期構成 | | | | | | |
| Jpix_ocr_task | データ分析 | | | | | | | |
| customer_area_visualization_task | データ分析 | | | | | | | |
| data_visualization_task | データ分析 | 実験段階 | | | | | | |
| Financial_evaluation_task_tool | データ分析 | | | | | | | |
| saitama-hospital-info-collector | データ分析 | | | | | | | |
| speech_to_text_analysis_task | データ分析 | 要ヒアリング | | | | | | |
| Medical_frontier_code | M&A他 | 事業ロードマップ | | | | | | |
| MA_Techno | M&A他 | | | | | | | |

---

## 1. Hatogaya系(鳩ヶ谷病院関連)

### Hatogaya_shift_automation_app(はとがやシフトマネージャー)
- **一言概要**: 7病棟分のシフト希望・制約をGoogle Sheetsで一元管理し、OR-Toolsソルバーで来月シフトを自動生成するWebアプリ。
- **課題**: 看護師/介護士の希望休・勤務制約・入退職・必要人数の手作業調整を、制約充足問題として自動化。夜勤回数の均等化や連続勤務制限も解として算出。
- **技術**: Python 3.12 / Firebase Functions gen2 / Google OR-Tools(CP-SAT) / Sheets API / GitHub Actions
- **AX的価値**: 属人的だったシフト作成を数理最適化で自動化。解なし時の自動緩和(仮想ヘルプ投入)まで実装済み。

### Hatogaya_talent_management
- **一言概要**: 人事システムjinjerとClaude APIを連携させた人材管理システム(配置転換・昇進管理・退職予測・履歴書分析)。
- **課題**: 異動申請ワークフロー、昇進候補抽出、退職リスクスコアリング、履歴書の自動解析・スキル抽出を支援。
- **技術**: Next.js 14 / TypeScript / FastAPI + PostgreSQL / Claude API / jinjer API連携
- **AX的価値**: 生成AI(Claude)による履歴書の自然文解析と、AIスコアリングによる退職予測の自動化。

### Job_quit
- **一言概要**: 給与・勤務状況・住所・生年月日等からRandomForest+SHAPで退職リスクを予測し、Firebase Hostingで可視化(稼働中: hatogaya-job-quit.web.app)。
- **課題**: 離職の予兆を勘に頼らず定量把握し、SHAP値で要因まで示し早期対応につなげる。
- **技術**: scikit-learn RandomForest / SHAP / 国土地理院API / Firebase Hosting
- **AX的価値**: 機械学習による離職予測というデータドリブン施策。既に稼働中のダッシュボードがあり説得力が高い。

### Data_for_receipt
- **一言概要**: クリニックのレセプト(診療報酬明細書)生データ(.UKE)を集計CSVに変換し、Streamlitダッシュボード(Cloud Run)で閲覧できるパイプライン。
- **課題**: レセプト集計・突合の手作業を自動化。bcryptによる認証などセキュリティにも配慮。
- **技術**: Python / pandas / Streamlit / Cloud Run / bcrypt認証
- **AX的価値**: 機微データ処理の自動パイプライン化。医療事務の定型集計自動化事例。

### Scrap_medical_job_detail_task
- **一言概要**: 医療系求人サイト「job-medley.com」から埼玉・東京の常勤求人をスクレイピングしExcelに整形、地図可視化(folium)まで対応。
- **課題**: 採用市場(給与水準・求人動向)の手作業競合調査を自動収集・整形に置き換え。
- **技術**: Python / Playwright / pandas / folium
- **AX的価値**: 採用競合分析の自動化。人手による求人サイト巡回・転記作業を代替。

### Firebase_Hatogaya_voice
- **一言概要**: 音声録音Firebaseプロジェクト。Gemini 2.5 Proの音声理解(最大約8.4時間)による要約・文字起こし・翻訳を想定。
- **課題**: 会議・現場音声のAI要約・文字起こしの仕組みを検証中。具体的な業務フローの記述はまだ薄い。
- **技術**: Firebase / Vertex AI Gemini 2.5 Pro
- **AX的価値**: 音声データ処理基盤の検証段階。実運用の証跡は別途補足が必要。

---

## 2. Negishi系(老健ねぎしケアセンター)

### Negishi_homecare_HP
- **一言概要**: 公式サイト。お知らせ・空室状況・求人情報をGoogle Sheets連携で自動反映し、問い合わせもFirebase Functionsで自動送信。
- **課題**: 空室・求人情報の更新をスプレッドシート編集のみで完結させ、Web制作会社を介さず現場が即時更新できるようにする。
- **技術**: Firebase Hosting/Functions / Sheets API / Gmail SMTP
- **AX的価値**: スプレッドシート更新だけでサイト反映される仕組みで、外部委託・手作業更新コストを削減。

### negishi_survey
- **一言概要**: 利用者・家族向け満足度調査フォーム。高評価時はGoogle口コミへ自動誘導するレビューゲーティングを実装。
- **課題**: 紙アンケート集計をなくし回答をSheetsへ自動集計。オンライン評価の底上げも狙う。
- **技術**: GAS / Google Sheets / QRコード生成
- **AX的価値**: azuma-jotformと同型テンプレートで施設横断的に再利用しており、標準化・横展開の実績として評価できる。

---

## 3. Azuma系(あずま在宅クリニック)

### azuma-jotform
- **一言概要**: 患者満足度調査フォーム。GAS経由でスプレッドシート保存、高評価はGoogleマップ口コミへ自動誘導。
- **課題**: negishi_surveyと同型で、患者アンケートの回収・集計・口コミ誘導を自動化。サーバー不要で低コスト運用。
- **技術**: Firebase Hosting / GAS / QRコード
- **AX的価値**: 低コスト自動アンケート基盤をクリニック単位で複製運用しているモデルケース。

### azuma-visit-clinic-hp
- **一言概要**: microCMSベースの公式コーポレートサイト。ニュース・事業内容・採用情報をCMS/スプレッドシートで管理。
- **課題**: 採用情報をSheetsから自動読込し、更新をスプレッドシート編集のみで完結。問い合わせもNodemailerで自動送信。
- **技術**: Next.js / microCMS / Sheets API / Nodemailer
- **AX的価値**: CMS+スプレッドシート連携によるノーコード運用化。
- ⚠️ READMEに本番認証情報が平文記載されているのを確認済み(下記「補足・注意事項」参照)。

---

## 4. Tokiwa / THS系

### Tokiwa-healthcare-service
- **一言概要**: ときわヘルスケアサービスの公式コーポレートサイト(microCMS公式テンプレートベース)。
- **課題**: ニュース・コンテンツ管理を非エンジニアが更新できるようにし、Firebase Hostingへ自動デプロイ。
- **技術**: Next.js / microCMS / Firebase Hosting
- **AX的価値**: コンテンツ更新の内製化・省力化。グループ広報基盤のデジタル化事例。
- ⚠️ READMEに本番認証情報が平文記載されているのを確認済み。

### THS_dentist_shift_automake_data
- **一言概要**: 歯科クリニック(DH/DA/受付等)のシフト自動化に向けた要件整理データ。特定業務日の人員配置ルールや個別制約を詳細に文書化。
- **課題**: 複雑な勤務ルールを属人的調整からルールエンジンによる自動シフト生成に置き換える計画段階の要件定義。
- **技術**: 要件定義段階(OR-Tools導入想定)
- **AX的価値**: Hatogaya_shift_automation_appの横展開計画。既存の稼働実績と合わせ「グループ全体へのロールアウト」という投資ストーリーが描ける。

---

## 5. 全社共通ツール系

### GCP_IAM_COST_CONTROL
- **一言概要**: GCP/Firebaseの課金状況をプロジェクト別・サービス別に集計し、ローカルGitリポジトリと紐づけて一覧表示するダッシュボード。
- **課題**: 複数プロジェクトに分散した費用把握の煩雑さを、CLI出力を集約した単一HTMLダッシュボードで解決。
- **技術**: gcloud CLI / Firebase CLI / BigQuery Billing
- **AX的価値**: クラウドコスト管理の可視化・自動化。IT統制文脈でのAX事例。

### Google_ads_control
- **一言概要**: 月間予算目標に合わせてキャンペーン日予算を毎日自動調整し、目標到達時は自動一時停止するペーシングスクリプト。
- **課題**: 広告予算の使い切り・超過防止の手動調整をなくし、目標から逆算した日予算自動配分を実現。
- **技術**: Google Ads API / cron
- **AX的価値**: 広告運用における反復判断の自動化。マーケティング業務の省力化。

### Google_drive_file_directory_change
- **一言概要**: Googleドライブ内ファイルをキーワード/拡張子ベースで自動分類、重複検出・命名整形も行う整理ツール(ドライラン既定)。
- **課題**: 増え続けるファイルの手作業整理を自動化。誤操作防止のため既定はドライランで安全設計。
- **技術**: Google Drive API v3
- **AX的価値**: バックオフィスのファイル管理自動化。TCB・ときわ関連フォルダも対象で社内文書管理に応用可。

### KJM_GAS_electricity_water_result_task
- **一言概要**: 電気・水道使用量集計結果をフロアごとにPDF化し、ZIPにまとめて自動メール送信するGASプロジェクト。
- **課題**: 光熱費集計レポートの作成・配布という定型事務作業を自動化。GitHub Actionsで自動デプロイ。
- **技術**: GAS / clasp / GitHub Actions
- **AX的価値**: 定型帳票の自動生成・配布。古典的だが効果の高い自動化事例。

### Auto-translation-task
- **一言概要**: 日本語のPowerPoint/Word/Excelファイルを Gemini API で自動翻訳(インドネシア語・ミャンマー語等、書式維持)。
- **課題**: 外国人スタッフ向けマニュアル等の翻訳を手作業から解放。キャッシュでAPIコストも抑制。
- **技術**: Gemini API / python-pptx / python-docx / openpyxl
- **AX的価値**: 外国人材受け入れが進む医療・介護現場での多言語マニュアル整備という具体的課題に直結。分かりやすいAX事例。

### auto_contact_form_task
- **一言概要**: 企業サイトの問い合わせフォームを自動検出し営業文面を送信するSeleniumボット(ルールベース版+Claude API版)。
- **課題**: 営業リストへのフォーム送信を自動化。AI版はセレクタ保守が不要になる設計。
- **技術**: Selenium / Claude API
- **AX的価値**: 営業活動自動化の具体例。ただし一斉自動送信は運用・倫理上の配慮が必要。

### google-maps-route-optimizer
- **一言概要**: Google Maps Routes APIで複数経由地の巡回ルートを最適化(CSV/Sheets入出力、Leaflet地図出力)。
- **課題**: 訪問診療・訪問介護等での複数拠点訪問順の最適化を自動算出。
- **技術**: Google Maps Routes API / Leaflet
- **AX的価値**: 訪問系サービスのルート最適化に直結しうる汎用ツール。移動効率化の効果訴求がしやすい。

### image_bg_task / Data_upload_and_download
- **一言概要**: 画像背景除去・自動クロップ・ICO/SVG変換ツールキット、および暫定的なTableauデータアップロードツール。
- **課題**: ロゴ制作の定型作業のAI自動化(rembg)、BI基盤への過渡的なデータ供給。
- **技術**: rembg / Selenium
- **AX的価値**: 単独の訴求力は弱いが、他施策を支える基盤ツールとして言及可能。Data_upload_and_downloadは未完成部分ありのため補助的位置づけ。

---

## 6. LINE・コミュニケーション系

### LINE_WORKS_SUMMARY
- **一言概要**: LINE WORKSのトーク履歴を毎日取得しGemini APIで要約、部署別スタイルで指定チャンネルに自動投稿するボット。
- **課題**: 大量チャットログの人手要約負担を排除。医療日報スタイルなど部署ごとのフォーマットにも対応。
- **技術**: LINE WORKS API / Gemini API
- **AX的価値**: 生成AIによる社内コミュニケーションログの自動要約。長文2段階要約など実運用に耐える工夫あり。

### LINE_LINEWORKS_GAS_SERVER_AI_CHATSERVICE
- **一言概要**: LINEとLINE WORKS両対応のAIチャットサービス。GAS+Gemini APIで構築、GitHub Actionsで自動デプロイ。
- **課題**: 患者・職員からの問い合わせ対応を自動応答化。RAG用ナレッジCSV・ベクターDBを保有。
- **技術**: GAS / Gemini API / LINE Messaging/WORKS API
- **AX的価値**: 生成AI+RAGによる問い合わせ対応自動化。稼働中のWebアプリが複数あり実運用段階にある点が強み。

### LINE_TASK_CONTROL
- **一言概要**: LINE WORKS APIでユーザー一覧取得・タスク作成・CSVからの一括タスク登録を行うスクリプト集。
- **課題**: 複数職員への一括タスク割り当てという定型管理業務を自動化。
- **技術**: LINE WORKS API
- **AX的価値**: 業務タスクの一括配信自動化。
- ⚠️ READMEに「過去のコミット履歴に秘密鍵等が残っている」旨の記載あり(下記参照)。

### AI_Voice_bot_netlify
- **一言概要**: Node.js経由でDialogflow CXに接続する音声ボットの土台(現状は固定応答、将来的にRAG化予定)。
- **課題**: 施設の音声応答(電話・受付等)自動化に向けた基盤。記載時点ではRAG化前の初期構成。
- **技術**: Dialogflow CX / Node.js
- **AX的価値**: 音声対話AI導入の初期段階。今後のRAG/生成AI化の実装状況を追記する必要あり。

---

## 7. データ分析・可視化系

### Jpix_ocr_task
- **一言概要**: 財務諸表PDFを表抽出・OCRしてExcel/Word化するTkinter GUI+CLIツール。
- **課題**: 財務諸表PDFからの手作業転記をなくし、表抽出とOCR(pytesseract)の両方に対応。
- **技術**: pdfplumber / pytesseract
- **AX的価値**: OCR×財務データ処理という、経理・財務事務の自動化に直結する分かりやすい事例。

### customer_area_visualization_task
- **一言概要**: 患者・顧客住所を国土地理院APIで緯度経度化し、埼玉・東京エリアの分布をインタラクティブ地図で可視化。
- **課題**: 顧客/患者の地理的分布を把握し、出店・営業エリア戦略の検討材料とする。
- **技術**: 国土地理院API
- **AX的価値**: 顧客データの地理空間分析自動化。エリア戦略立案の高度化事例。

### data_visualization_task
- **一言概要**: アソシエーション分析・決定木・ネットワークグラフ・サンキー等、多様な分析手法を試す実験基盤(取引データ想定)。
- **課題**: 施術項目間の関連性分析や取引属性分類予測など、経営データの高度分析を内製化。
- **技術**: scikit-learn / Plotly / pyvis
- **AX的価値**: データ分析の内製化・高度化基盤。経営会議向け分析ケイパビリティ構築の文脈で言及可能。

### Financial_evaluation_task_tool
- **一言概要**: PL/BSベースの財務指標分析・M&Aアプローチ優先度スコアリング・簡易企業価値評価ツール群。
- **課題**: M&A候補企業の財務評価をExcel/CSVまたはEDINETデータから半自動で実施。
- **技術**: Python / EDINET連携
- **AX的価値**: M&A関連業務を支える分析自動化ツールと推測。実装詳細は個別ディレクトリ参照。

### saitama-hospital-info-collector
- **一言概要**: 埼玉県の在宅療養支援診療所・病院データをJMAPから収集し、Gemini APIで公式サイトを要約・特徴タグ付けする競合分析パイプライン。
- **課題**: 地域医療機関の競合分析(診療内容・強み等)を自動収集・AI要約・スコアリングまで一貫実行。
- **技術**: Gemini API / openpyxl
- **AX的価値**: 経営企画・エリア戦略業務に直結する高度なAX事例。訴求力が高い部類。

### speech_to_text_analysis_task
- **一言概要**: 音声データの文字起こし(Whisper+pyannote話者分離)とキーワード頻度・spaCy/GiNZAによるテキスト分析。
- **課題**: 会議・面談記録の文字起こしと内容分析の自動化と推測(README記載が薄く要ヒアリング)。
- **技術**: Whisper / GiNZA
- **AX的価値**: 議事録・面談記録自動化に応用できる基盤技術。実適用業務の具体化が必要。

---

## 8. M&A・その他

### Medical_frontier_code
- **一言概要**: 「会社資産」と明記された複数事業の概要記述リポジトリ(コンヴァノ=RPA、M&Aテクノ=スクレイピング等、メディカルフロンティア=動画/テキスト分析とBI)。
- **課題**: グループ内の複数自動化・分析事業を統括的に記述。2025年12月までに正式リポジトリへ移行予定と記載。
- **技術**: RPA全般 / BI基盤(予定)
- **AX的価値**: 個別ツールではなく事業ロードマップ的位置づけ。複数のAX事業ラインが並行進行中であることの根拠資料。

### MA_Techno
- **一言概要**: 企業リストのスクレイピング支援スクリプト集(法人番号から企業情報取得等)。
- **課題**: M&A候補企業の情報収集(電話・URL・住所等)を手作業から自動収集に置き換え。
- **技術**: Pythonスクレイピング
- **AX的価値**: M&A支援業務の効率化という具体的文脈がある情報収集自動化ツール。

---

## 9. 判断が分かれるもの

体裁は業務ツールだが、Tokiwaグループの内部業務というより個人事業・別法人の可能性が高いもの。会議資料への採用は要検討。

| リポジトリ名 | 概要 |
|---|---|
| Ser_inc_HP | SER Inc.(日韓ビジネスの橋渡し、METAX/Healthcare/Entertainmentの3事業)のコーポレートサイト。Tokiwaグループとは別法人の可能性が高い |
| YRC-shukatsu-lab | 外資・日系就活支援Webアプリ(Gemini 2.5 FlashによるAIエントリーシート添削)。個人/別事業のプロダクトと見られる |
| All_general_data_for_barng | 個人のファイル整理アーカイブ。ツールというより個人の管理体系 |
| barng-career-site | 個人の経歴紹介サイト。主要事績としての計上は非推奨 |

---

## 10. README情報不足で判断できなかったもの

| リポジトリ名 | 状況 |
|---|---|
| Hatogaya_knowledge_share_web_system | README本文なし(タイトルのみ)。鳩ヶ谷向け知識共有システムと推測 |
| Hatogaya-medical-chat-bot | README本文なし(タイトルのみ)。医療チャットボットと推測 |
| Tokiwa-hatogaya-study-app | README本文なし(タイトルのみ) |
| hatogaya_jotform | Firebase設定コードの貼り付けのみで機能説明なし |
| hatogaya_jobhunting | Next.js標準テンプレートの雛形のまま |
| Geocoding_visualization | README完全に空 |
| suumo_rental_scraper_task | README・リポジトリ説明ともに空欄 |
| Scrap_for_park / Scrap_for_park_sub | README空欄。業務との関連性も不明 |
| ai_diary_app | Flutter標準テンプレートの雛形のまま |

---

## 補足・注意事項

### ⚠️ セキュリティ注意

調査の過程で、以下のリポジトリのREADME.mdにFirebase構成キー・秘密鍵・Gmailアプリパスワード等の認証情報がそのまま記載されているのを確認しました。本レポートには一切転記していませんが、社外への共有前に該当キーのローテーションとREADMEからの削除を推奨します。

- azuma-visit-clinic-hp
- LINE_TASK_CONTROL
- Firebase_Hatogaya_voice
- Tokiwa-healthcare-service
- hatogaya_jotform
- YRC-shukatsu-lab、Barng_resume(別途確認済み)

### 補助金プログラム名について

各ツールがどの補助金制度(IT導入補助金、事業再構築補助金等)に該当するかはREADMEからは断定できないため、本レポートでは具体的な制度名の記載を避け、機能・効果の説明にとどめています。制度適合性の判断は別途、実際の申請要件と照合してください。

### 全体傾向

シフト自動化(Hatogaya→THS歯科への横展開)、アンケート/口コミ自動化(Negishi・Azuma共通テンプレート化)、生成AI活用(Gemini/Claudeによる要約・翻訳・チャット・競合分析)、データ可視化(顧客地理分析・財務評価)の4系統が、補助金申請のストーリーとして特に厚みがあります。
