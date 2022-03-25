class UsersController < ApplicationController
  def show
    @name = current_user.name
    @schedules = Schedule.where(id: current_user.schedules)
    @user = User.where(id: params[:id])
  end

end
