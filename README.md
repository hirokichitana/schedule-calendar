# アプリケーション名
Schedule Calendar

# アプリケーション概要
メンバー間で互いの予定を共有し確認する事で、部下の管理やサポートなど、メンバー間で連携が取りやすくなる。

# URL
https://schedule-calendar-0630.herokuapp.com/

# テスト用アカウント
* Basic認証ID：tanaka
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

# 実装予定の機能
Bootstrapを使いviewを整える（実装中）  
Google Maps APIを使用し予定詳細へ地図を表示させる機能を実装予定

# データベース設計
<img width="757" alt="スクリーンショット 2022-04-17 1 33 15" src="https://user-images.githubusercontent.com/94688508/163683505-179436f5-0f27-4a8a-b26b-a3a8c147d680.png">


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

| Column             | Type       | Options                          |
| ------------------ | ---------- | -------------------------------- |
| title              | string     | null: false                      |
| content            | text       | null: false                      |
| start_time         | datetime   | null: false                      |
| end_time           | datetime   | null: false                      |
| zip_code           | text       |                                  |
| prefecture         | text       |                                  |
| city               | text       |                                  |
| town               | text       |                                  |
| building_name      | text       |                                  |
| user               | references | null: false, foreign_key: true   |

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

# 画面遷移図
<img width="852" alt="スクリーンショット 2022-04-17 1 30 32" src="https://user-images.githubusercontent.com/94688508/163683425-152dcdc0-88ba-482e-86cc-a79f16d26059.png">

# 開発環境
* Ruby 2.6.5
* Ruby on Rails 6.0.0
* MySQL 4.4
* Heroku
* Github
* Visual Studio Code
* simple_calendar
* i18n_generators
* devise
* gretel
* rspec-rails
* pry-rails
* factory_bot_rails
* faker
* YubinBango
* rails-i18n
* Bootstrap 5.0
* VOV.CSS
* Rubocop

# ローカルでの動作方法
以下のコマンドを順に実行  
% git clone https://github.com/hirokichitana/schedule-calendar.git  
% cd schedule-calendar  
% bundle install  
% yarn install

# 工夫したポイント
## 使いやすさにこだわったアプリケーション
Schedule Calendarは使用する全ユーザーにとって「優しいアプリケーション」である事をテーマにして開発いたしました。  
「優しい」とは、シンプルで見やすく使いやすいアプリである事を大切にしております。
### シンプルな画面デザイン
Schedule Calendarは20代〜50代の男女が使用する事を想定しております。  
よって画面デザインは、どんな人でも使いやすいようシンプルである事にこだわりました。  
また、ページ遷移ボタンを基本的に画面上部へ設置する事で、ユーザーがページ移動の際に迷わないよう意識いたしました。
### 住所の自動入力機能
YubinBangoというjsライブラリを使用して住所の自動入力機能を実装いたしました。  
これにより、ユーザーは郵便番号を入力するだけで町域までの住所が自動入力されます。  
よってユーザーの入力文字数を減らす事ができ、さらに誤字脱字も防ぐ事ができます。
### メール機能
自分以外のユーザー詳細ページにある「○○さんへメールを送る」ボタンをクリックする事で、利用者側でメールクライアントが起動し、設定されている宛先の情報が自動的に設定されます(送信はされません)。
これにより、ユーザーは件名、内容を入力するだけで簡単にメールを送信する事ができます。
