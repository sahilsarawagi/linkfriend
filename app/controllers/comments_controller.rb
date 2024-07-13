class CommentsController < ApplicationController

  def create
    @user = current_user
    @comment = @user.comments.new(comment_params)

    if @comment.save
      update_comment(@comment,@comment.post)
      Notification.create( recipient: @comment.post.user,
                           actor_id: current_user.id,
                           action: "commented on your post",
                           notifiable: @comment
                          )
    else
      render :index, status: :unprocessable_entity
    end
  end
  
  private
    def comment_params
      params.require(:comment).permit(:comment,:post_id)
    end
    def update_comment(comment,post)
      render turbo_stream:
            turbo_stream.replace( "comment_#{post.id}",
              partial: "shared/comment",
              locals:{ post:post, comment: comment}
            )
    end
end