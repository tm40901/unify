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
- has_many :instruments
- has_many :inspection_submissions


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
- belongs_to :user
- has_many :inspection_items
- has_many :inspection_results
- has_many :inspection_submissions


## inspection_items テーブル
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| instrument | references | null: false, foreign_key: true |
| item       | references | null: false                    |

### Association
- belongs_to :instrument
- has_many :inspection_results


## inspection_results テーブル
| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| instrument            | references | null: false, foreign_key: true |
| inspection_item       | references | null: false, foreign_key: true |
| result                | string     | null: false                    |
| inspection_submission | references | null: false, foreign_key: true |

### Association
- belongs_to :instrument
- belongs_to :inspection_item
- belongs_to :inspection_submission


## inspection_submissions テーブル
| Column       | Type       | Options                                       |
| ------------ | ---------- | --------------------------------------------- |
| instrument   | references | null: false, foreign_key: true                |
| inspector    | references | null: false, foreign_key: { to_table: users } |
| approver     | references | null: false, foreign_key: { to_table: users } |
| status       | string     | null: false                                   |
| submitted_at | datetime   |                                               |
| approved_at  | datetime   |                                               |

### Association
- belongs_to :instrument
- belongs_to :user
- has_many :inspection_results