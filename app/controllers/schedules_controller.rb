class SchedulesController < ApplicationController
  
  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def create
    Schedule.create(schedule_parameter)
    redirect_to root_path
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to root_path
  end

  private

  def schedule_parameter
    params.require(:schedule).permit(:title, :content, :start_time)
  end
end
