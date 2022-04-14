class UsersController < ApplicationController

  before_action :move_to_index, only: :show

  def show
    user = User.find(params[:id])
    @schedules = user.schedules
    @user = User.where(id: params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to root_path
    end
  end

end
