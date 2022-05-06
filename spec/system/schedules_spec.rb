require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Schedules", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @schedule = FactoryBot.create(:schedule)
  end

  context 'スケジュールを投稿できるとき'do
    it 'ログインし、正しく情報を入力したユーザーは新規投稿できる' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ログインする
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
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
      expect{
        find('input[name="commit"]').click
      }.to change { Schedule.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のスケジュールが存在することを確認する
      expect(page).to have_content(@schedule.title)
    end
  end
  context 'スケジュールを投稿がきないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('新規予定')
    end
  end
  context 'スケジュールを投稿できないとき'do
    it '正しく情報を入力しなければ予定を投稿できない' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ログインする
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('新規予定')
      # 新規投稿ページに移動する
      visit new_schedule_path
      # フォームに情報を入力する
      fill_in 'タイトル（必須）', with: ''
      fill_in '開始日時（必須）', with: ''
      fill_in '終了日時（必須）', with: ''
      fill_in '詳細（必須）', with: ''
      # 送信するとScheduleモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Schedule.count }.by(0)
      # 新規投稿ページへ戻されることを確認する
      expect(current_path).to eq schedules_path
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content('タイトルを入力してください')
      expect(page).to have_content('内容を入力してください')
      expect(page).to have_content('開始時間を入力してください')
      expect(page).to have_content('終了時間を入力してください')
    end
  end
end
