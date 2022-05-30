module LogInSupport
  def log_in(schedule)
    fill_in 'タイトル（必須）', with: schedule.title
    fill_in '開始日時（必須）', with: schedule.start_time
    fill_in '終了日時（必須）', with: schedule.end_time
    fill_in '詳細（必須）', with: schedule.content
  end
end