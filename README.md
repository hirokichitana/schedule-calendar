# アプリケーション名
Schedule Calendar

# アプリケーション概要
社内等で互いの予定を共有し、コミュニケーションを取る事により、部下の管理やサポート、商談等のアドバイスやフィードバックに役立てる事ができる。

# URL
https://schedule-calendar-0630.herokuapp.com/

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| name               | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| birth_date         | date    | null: false               |
| department         | string  |                           |
| position           | string  |                           |

### Association

  has_many :schedules
  has_many :comments



## schedules テーブル

| Column             | Type     | Options                          |
| ------------------ | -------- | -------------------------------- |
| title              | string   | null: false                      |
| content            | text     | null: false                      |
| start_time         | datetime | null: false                      |
| end_time           | datetime | null: false                      |
| user               | references | null: false, foreign_key: true |

### Association

  belongs_to :user
  has_many :comments



## comments テーブル

| Column             | Type       | Options                          |
| ------------------ | ---------- | -------------------------------- |
| text               | text       | null: false                      |
| schedule           | references | null: false, foreign_key: true   |
| user               | references | null: false, foreign_key: true   |

### Association

  belongs_to :schedule
  belongs_to :user