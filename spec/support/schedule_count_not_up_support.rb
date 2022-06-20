module ScheduleCountNotUpSupport
  def schedule_count_not_up
    expect  do
      find('input[name="commit"]').click
    end.to change { Schedule.count }.by(0)
  end
end