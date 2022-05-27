module SignInSupport
  def sign_in(user)
    # ログインページへ遷移する
    visit new_user_session_path
    # ログインする
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
  end
end