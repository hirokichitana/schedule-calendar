module CommentCountNotUpSupport
  def comment_count_not_up
    expect  do
      find('input[name="commit"]').click
    end.to change { Comment.count }.by(0)
  end
end