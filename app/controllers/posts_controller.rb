class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @post = Post.new
    @comment = Comment.new
    @posts = Post.includes(:user, :comments, :likes).all
  end
  
  def create
    @user = current_user
    @post = @user.posts.new(post_params)

    if @post.save
      redirect_to :root
    else
      render :index, status: :unprocessable_entity
    end
  end

  def like
    @post = Post.find(params[:id])
    @post.likes.create(user_id: current_user.id)
  
    Notification.create( recipient: @post.user,
                          actor_id: current_user.id,
                          action: "liked your post",
                          notifiable: @post
                        )
    update_like_button(@post)
                        
  end

  def unlike
    @post = Post.find(params[:id])
    @post.likes.find_by(user_id: current_user.id).destroy
    update_like_button(@post)
  end

  def likes
    @post = Post.find(params[:id])
    @post_like_users = post_like_users(@post.likes)
  end

  private
    def post_params
      params.require(:post).permit(:body,:photo)
    end

    def post_like_users(likes)
      likes.map(&:user)
    end

    def update_like_button(post)
      render turbo_stream:
            turbo_stream.replace( "like_button_#{@post.id}",
              partial: "shared/like",
              locals:{post: post, post_like_exist: post.likes.exists?(user_id: current_user.id)}
            )
    end
end
