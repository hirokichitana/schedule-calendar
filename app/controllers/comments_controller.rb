class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/schedules/#{comment.schedule.id}"
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to "/schedules/#{@comment.schedule.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, schedule_id: params[:schedule_id])
  end
end
