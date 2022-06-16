module ScheduleCountUpSupport
  def schedule_count_up
    expect  do
      find('input[name="commit"]').click
    end.to change { Schedule.count }.by(1)
  end
end