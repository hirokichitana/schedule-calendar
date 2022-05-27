require 'rails_helper'

def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'v', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @schedule = FactoryBot.create(:schedule)
    @comment = FactoryBot.create(:comment)
  end

  context 'コメントを投稿できるとき' do
    it 'ログインし、スケジュールが存在し、コメントを入力したユーザーは投稿できる' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
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
      expect  do
        find('input[name="commit"]').click
      end.to change { Schedule.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のスケジュールが存在することを確認する
      expect(page).to have_content(@schedule.title)
      # 先ほど投稿したスケジュールの詳細画面へ遷移する
      visit schedule_path(@schedule.id)
      # フォームに情報を入力する
      fill_in 'comment_text', with: @comment.text
      # 送信するとScheduleモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Comment.count }.by(1)
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
      visit new_user_session_path
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
      expect  do
        find('input[name="commit"]').click
      end.to change { Schedule.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のスケジュールが存在することを確認する
      expect(page).to have_content(@schedule.title)
      # 先ほど投稿したスケジュールの詳細画面へ遷移する
      visit schedule_path(@schedule.id)
      # フォームに情報を入力する
      fill_in 'comment_text', with: ''
      # 送信するとScheduleモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Comment.count }.by(0)
    end
  end
end
