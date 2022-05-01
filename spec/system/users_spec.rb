require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      def basic_pass(path)
        username = ENV["BASIC_AUTH_USER"]
        password = ENV["BASIC_AUTH_PASSWORD"]
        visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
      end
      basic_pass root_path
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in '名前（必須）', with: @user.name
      fill_in '電話番号（必須）', with: @user.telephone_number
      fill_in 'メールアドレス（必須）', with: @user.email
      fill_in 'パスワード（必須）', with: @user.password
      fill_in 'パスワード確認（必須）', with: @user.password_confirmation
      select '1991',from: 'user[birth_date(1i)]'
      select '12',from: 'user[birth_date(2i)]'
      select '12',from: 'user[birth_date(3i)]'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in '名前（必須）', with: ''
      fill_in '電話番号（必須）', with: ''
      fill_in 'メールアドレス（必須）', with: ''
      fill_in 'パスワード（必須）', with: ''
      fill_in 'パスワード確認（必須）', with: ''
      select '--',from: 'user[birth_date(1i)]'
      select '--',from: 'user[birth_date(2i)]'
      select '--',from: 'user[birth_date(3i)]'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content('Eメールを入力してください')
      expect(page).to have_content('パスワードを入力してください')
      expect(page).to have_content('パスワードは不正な値です')
      expect(page).to have_content('名前を入力してください')
      expect(page).to have_content('生年月日を入力してください')
      expect(page).to have_content('電話番号を入力してください')
      expect(page).to have_content('電話番号は不正な値です')
    end
  end
end
