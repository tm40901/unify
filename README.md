# アプリケーション名
UNiFY


# アプリケーション概要
計測器の台帳管理・点検・承認申請まで、一元で管理することのできるアプリケーション


# URL
https://originalapp-unify-40901.onrender.com


# テスト用アカウント
## 管理者
メールアドレス：admin@test.com<br>
パスワード：admin2024

## 点検者
メールアドレス：inspector@test.com<br>
パスワード：inspector2024


# 利用方法
## 共通
- トップページから登録されている計測器の詳細を閲覧することができます。
- サイドバーの「予約カレンダー」から計測器の予約することができます。
- ヘッダーの登録者名からマイページに遷移し、該当する計測器の情報を取得できます。
## 管理者
- サイドバーの「計測器新規登録」から、計測器を新規登録することができます。
- 計測器一覧の管理番号から計測器詳細を開き、該当する管理者であれば点検項目を追加することができます。
- 自身宛てに申請が来ている場合、サイドバー「承認待ち」から承認待ちの数を確認することができます。
- サイドバーの「承認待ち」から、自身宛ての点検結果が表示され、承認することができます。承認することで計測器の最終点検日が更新されます。
## 点検者
- トップページから登録されている計測器の詳細を閲覧することができ、自身が点検者に該当する計測器の場合は点検実施することができます。


# アプリケーションを作成した背景
## 背景
自身が経験した計測器管理業務は紙運用が主体であり、承認に時間がかかる等多くの課題が発生していました。部署ごとに計測器を保有し、各部署の管理者が異なる方法で管理していたため、会社全体の計測器の把握や統一的な管理が難しい状況にありました。さらに、点検記録の管理が不十分で、計測器の状態や点検状況の把握が困難でした。
## 解決する課題・提供価値
- 情報の一元化：部署ごとに分散している計測器管理情報を一元化し、全社的な統一された管理を実現することが可能になります。
- 工数削減： 計測器の管理、点検、承認を一括で行えることにより、管理にかかる工数の削減が期待できます。


# データベース設計
[![Image from Gyazo](https://i.gyazo.com/f9ea8d285d262852611f6349166bec19.png)](https://gyazo.com/f9ea8d285d262852611f6349166bec19)


# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/0048856a92e07188363c5bc25314a011.png)](https://gyazo.com/0048856a92e07188363c5bc25314a011)


# テーブル設計
## users テーブル
| Column          | Type   | Options                   |
| --------------- | ------ | ------------------------- |
| email           | string | null: false, unique: true |
| password        | string | null: false               |
| employee_number | string | null: false               |
| last_name       | string | null: false               |
| first_name      | string | null: false               |
| department      | string | null: false               |
| role            | string | null: false               |
### Association
- has_many :admin_instruments, class_name: "Instrument", foreign_key: "admin_id"
- has_many :inspector_instruments, class_name: "Instrument", foreign_key: "inspector_id"
- has_many :inspector_inspection_results, class_name: "InspectionResult", foreign_key: "inspector_id"
- has_many :approver_inspection_results, class_name: "InspectionResult", foreign_key: "approver_id"
- has_many :reservations


## instruments テーブル
| Column            | Type       | Options                                       |
| ----------------- | ---------- | --------------------------------------------- |
| name              | string     | null: false                                   |
| admin             | references | null: false, foreign_key: { to_table: users } |
| inspector         | references | null: false, foreign_key: { to_table: users } |
| management_number | string     | null: false, unique: true                     |
| manufacturer      | string     |                                               |
| model             | string     |                                               |
| serial_number     | string     |                                               |
| last_inspected_at | datetime   |                                               |
### Association
- belongs_to :admin, class_name: "User"
- belongs_to :inspector, class_name: "User"
- has_many :inspection_items
- has_many :inspection_results
- has_many :reservations


## inspection_items テーブル
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| instrument | references | null: false, foreign_key: true |
| item       | references | null: false                    |
### Association
- belongs_to :instrument
- has_many :inspection_results


## inspection_results テーブル
| Column                | Type       | Options                                       |
| --------------------- | ---------- | --------------------------------------------- |
| instrument            | references | null: false, foreign_key: true                |
| inspection_item       | references | null: false, foreign_key: true                |
| inspector             | references | null: false, foreign_key: { to_table: users } |
| approver              | references | null: false, foreign_key: { to_table: users } |
| result                | string     | null: false                                   |
| custom_id             | string     | null: false                                   |
| status                | string     | null: false                                   |
### Association
- belongs_to :instrument
- belongs_to :inspection_item
- belongs_to :inspector, class_name: "User"
- belongs_to :approver, class_name: "User"


## reservations テーブル
| Column     | Type       | Options                        |
| ---------- | ---------- | -------------------------------|
| instrument | references | null: false, foreign_key: true |
| user       | references | null: false, foreign_key: true |
| start_time | datetime   | null: false                    |
| end_time   | datetime   | null: false                    |
### Association
- belongs_to :instrument
- belongs_to :user

# 工夫したポイント
- ユーザーの負担を軽減するため、シンプルかつ直感的に操作できるユーザーインターフェースを意識してデザインしました。
- 本アプリケーションは Ruby on Rails 7 を使用して開発しました。Railsの基本機能に加え、動的なユーザー体験を提供するために JavaScript を積極的に採用しました。ユーザーの操作感を向上させるため、モーダルウィンドウ や サイドバー の表示切替を実装しました。

# 実装予定の機能
- トップページ、予約カレンダーにおける検索機能