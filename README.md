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