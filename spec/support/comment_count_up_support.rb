module CommentCountUpSupport
  def comment_count_up
    expect  do
      find('input[name="commit"]').click
    end.to change { Comment.count }.by(1)
  end
end