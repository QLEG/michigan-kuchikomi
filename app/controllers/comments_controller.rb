class CommentsController < ApplicationController
  before_action :correct_user,   only: :destroy

  def create
    @comment = Comment.new comment_params
    @comment.user_id = current_user.id

    respond_to do |format|
      format.js {
        if @comment.save
          @comments = Comment.where(post_id: @comment.post_id)
          render "comments/create"
        else
          #unable to save
        end
      }
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "コメントは削除されました"
    redirect_to request.referrer || root_url
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end

  def comment_params
    params.require(:comment).permit(:message, :post_id)
  end
end