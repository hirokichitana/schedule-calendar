class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @schedules = user.schedules
    @user = User.where(id: params[:id])
  end

end
