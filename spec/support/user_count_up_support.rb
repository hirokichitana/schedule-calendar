module UserCountUpSupport
  def user_count_up
    expect do
      find('input[name="commit"]').click
    end.to change { User.count }.by(1)
  end
end