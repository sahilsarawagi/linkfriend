class CommentsController < ApplicationController

  def create
    @user = current_user
    @comment = @user.comments.new(comment_params)

    if @comment.save
      @notify = Notification.create( recipient: @comment.post.user,
                           actor_id: current_user.id,
                           action: "commented on your post",
                           notifiable: @comment
                          )

      html = render(partial: 'shared/notification',locals: {notification: @notify})
      ActionCable.server.broadcast "notifications:2", {html: html}

      # redirect_back(fallback_location: users_path)
    else
      render :index, status: :unprocessable_entity
    end
  end
  
  private
    def comment_params
      params.require(:comment).permit(:comment,:post_id)
    end
end