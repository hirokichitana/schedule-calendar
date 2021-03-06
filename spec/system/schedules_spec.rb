require 'rails_helper'

RSpec.describe 'Schedules', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @schedule = FactoryBot.create(:schedule)
    sleep(0.1)
  end

  context 'スケジュールを投稿できるとき' do
    it 'ログインし、正しく情報を入力したユーザーは新規投稿できる' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit user_session_path
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
    end
  end
  context 'スケジュールを投稿がきないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('新規予定')
    end
  end
  context 'スケジュールを投稿できないとき' do
    it '正しく情報を入力しなければ予定を投稿できない' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit user_session_path
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('新規予定')
      # 新規投稿ページに移動する
      visit new_schedule_path
      # フォームに情報を入力する
      fill_in 'タイトル（必須）', with: ''
      fill_in '開始日時（必須）', with: ''
      fill_in '終了日時（必須）', with: ''
      fill_in '詳細（必須）', with: ''
      # 送信してもScheduleモデルのカウントが上がらないことを確認する
      schedule_count_not_up
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

RSpec.describe 'Schedules', type: :system do
  before do
    @schedule1 = FactoryBot.create(:schedule)
    @schedule2 = FactoryBot.create(:schedule)
  end
  context 'スケジュール編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したスケジュールの編集ができる' do
      # ログインページへ遷移する
      visit user_session_path
      # スケジュール1を投稿したユーザーでログインする
      sign_in(@schedule1.user)
      # スケジュール1詳細ページへ遷移する
      visit schedule_path(@schedule1.id)
      # スケジュール1に「予定の編集」へのリンクがあることを確認する
      expect(page).to have_content('予定の編集')
      # 「予定の編集」画面へ遷移する
      visit edit_schedule_path(@schedule1)
      # 投稿内容を編集する
      fill_in 'タイトル（必須）', with: @schedule1.title
      fill_in '開始日時（必須）', with: @schedule1.start_time
      fill_in '終了日時（必須）', with: @schedule1.end_time
      fill_in '詳細（必須）', with: @schedule1.content
      # 編集してもScheduleモデルのカウントは上がらないことを確認する
      schedule_count_not_up
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のスケジュールが存在することを確認する
      expect(page).to have_content(@schedule1.title)
    end
  end
  context 'スケジュール編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したスケジュールの編集画面には遷移できない' do
      # ログインページへ遷移する
      visit user_session_path
      # ツイート1を投稿したユーザーでログインする
      sign_in(@schedule1.user)
      # スケジュール2詳細ページへ遷移する
      visit schedule_path(@schedule2.id)
      # ツイート2に「予定の編集」へのリンクがないことを確認する
      expect(page).to have_no_content('予定の編集')
    end
    it 'ログインしていないとスケジュールの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # スケジュール1詳細ページへ遷移する
      visit schedule_path(@schedule1.id)
      # ツイート1に「予定の編集」へのリンクがないことを確認する
      expect(page).to have_no_content('予定の編集')
    end
  end
end