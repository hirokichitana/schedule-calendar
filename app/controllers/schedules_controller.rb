class SchedulesController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  
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
    redirect_to root_path, notice:"削除しました"
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_parameter)
      redirect_to root_path, notice: "編集しました"
    else
      render 'edit'
    end
  end


  private

  def schedule_parameter
    params.require(:schedule).permit(:title, :content, :start_time, :end_time ).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
