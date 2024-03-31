class CommentsController < ApplicationController
  def create
    @user = current_user
    @comment = @user.comments.new(comment_params)

    if @comment.save
      redirect_to :root
    else
      render :index, status: :unprocessable_entity
    end
  end
  private
    def comment_params
      params.require(:comment).permit(:comment,:post_id)
    end
end