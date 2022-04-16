# アプリケーション名
Schedule Calendar

# アプリケーション概要
社内等で互いの予定を共有し、コミュニケーションを取る事により、部下の管理やサポート、商談等のアドバイスやフィードバックに役立てる事ができる。

# URL
https://schedule-calendar-0630.herokuapp.com/

# テスト用アカウント
* Basic認証パスワード：tanaka
* Basic認証パスワード：6301015
* メールアドレス：test@test
* パスワード：test123

# 利用方法

## 予定投稿
1.トップページ（予定一覧ページ）のヘッダーからユーザー登録を行う  
2.新規予定ボタンから、予定の内容（タイトル、開始時間、終了時間、内容、郵便番号、住所）を入力し「予定を登録する」ボタンをクリックする

## コメントを投稿する
1.トップページ（予定一覧ページ）からコメントを送る予定をクリックして、予定の詳細を確認する。  
2.フォームにコメントを入力し、「コメント投稿」ボタンをクリックする

# アプリケーションを作成した背景
職場の同僚（営業職、20代〜50代、男女）に仕事上の課題をヒアリングしたところ、「職場内メンバー（上司、同僚および部下）の予定がわからない」という課題を抱えていることが判明した。  
なぜ互いの予定を把握できないのか、課題を分析したところ、「終日営業に出かけているため予定を確認する事ができない」、「取引先の都合により予定が変更される事が多い」という２点が真因ではないかと仮説を立てた。  
同様の課題を抱えている人が多いと考え、真因を解決するため、メンバーの予定をリアルタイムで共有し、互いに確認する事ができ、必要に応じてコメント機能でアドバイス等もできるアプリケーションを開発することにした。

# 洗い出した要件
https://docs.google.com/spreadsheets/d/14h1gLXpCPO-xmKwL0UVXvfZG6t1lBy-Vk1XmyuFk2cA/edit?usp=sharing

# データベース設計
<img width="759" alt="スクリーンショット 2022-04-15 23 42 26" src="https://user-images.githubusercontent.com/94688508/163584596-dfe08039-cb5d-49c4-b1f2-394fe7773feb.png">


## users テーブル


| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| name               | string  | null: false               |
| telephone_number   | string  | null: false               |
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