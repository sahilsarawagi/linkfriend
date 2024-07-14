class CommentsController < ApplicationController

  def create
    @user = current_user
    @comment = @user.comments.new(comment_params)

    if @comment.save
      Notification.create( recipient: @comment.post.user,
                           actor_id: current_user.id,
                           action: "commented on your post",
                           notifiable: @comment
                          )
      update_comment(@comment,@comment.post)
    else
      render :index, status: :unprocessable_entity
    end
  end
  
  private
    def comment_params
      params.require(:comment).permit(:comment,:post_id)
    end
    def update_comment(comment,post)
      render turbo_stream: [
        turbo_stream.before( "comment_#{post.id}",
              partial: "shared/comment",
              locals:{ post:post, comment: comment}
            ),
        turbo_stream.replace("comment_count#{post.id}", 
              partial: "shared/comment_count", 
              locals: { count: post.comments.count, post: post })
      ]
    end
end