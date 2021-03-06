require 'rails_helper'

RSpec.describe 'comments', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @schedule = FactoryBot.create(:schedule)
    @comment = FactoryBot.create(:comment)
    sleep(0.1)
  end

  context 'コメントを投稿できるとき' do
    it 'ログインし、スケジュールが存在し、コメントを入力したユーザーは投稿できる' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit_log_in
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('新規予定')
      # 投稿ページに移動する
      visit new_schedule_path
      # フォームに情報を入力する
      schedule(@schedule)
      # 送信するとScheduleモデルのカウントが1上がることを確認する
      schedule_count_up
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のスケジュールが存在することを確認する
      expect(page).to have_content(@schedule.title)
      # 先ほど投稿したスケジュールの詳細画面へ遷移する
      visit schedule_path(@schedule.id)
      # フォームに情報を入力する
      fill_in 'comment_text', with: @comment.text
      # 送信するとCommentモデルのカウントが1上がることを確認する
      comment_count_up
      # 先ほど投稿した内容のコメントが存在することを確認する
      expect(page).to have_content(@comment.text)
    end
  end
  context 'コメントを投稿できないとき' do
    it 'ログインし、スケジュールが存在し、コメントが空欄では投稿できない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit_log_in
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('新規予定')
      # 投稿ページに移動する
      visit new_schedule_path
      # フォームに情報を入力する
      fill_in 'タイトル（必須）', with: @schedule.title
      fill_in '開始日時（必須）', with: @schedule.start_time
      fill_in '終了日時（必須）', with: @schedule.end_time
      fill_in '詳細（必須）', with: @schedule.content
      # 送信するとScheduleモデルのカウントが1上がることを確認する
      schedule_count_up
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のスケジュールが存在することを確認する
      expect(page).to have_content(@schedule.title)
      # 先ほど投稿したスケジュールの詳細画面へ遷移する
      visit schedule_path(@schedule.id)
      # フォームに情報を入力する
      fill_in 'comment_text', with: ''
      # 送信するとCommentモデルのカウントが上がらないことを確認する
      comment_count_not_up
    end
  end
end
