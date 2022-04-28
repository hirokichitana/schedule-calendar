class SchedulesController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :destroy]

  def index
    @schedules = Schedule.includes(:user)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.create(schedule_parameter)
    if @schedule.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
    @comment = Comment.new
    @comments = @schedule.comments.includes(:user)
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to root_path, notice: '削除しました'
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_parameter)
      redirect_to root_path, notice: '編集しました'
    else
      render 'edit'
    end
  end

  private

  def schedule_parameter
    params.require(:schedule).permit(:title, :content, :start_time, :end_time, :zip_code, :prefecture, :city, :town,
                                     :building_name).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def contributor_confirmation
    schedule = Schedule.find(params[:id])
    redirect_to root_path unless current_user == schedule.user
  end
end
