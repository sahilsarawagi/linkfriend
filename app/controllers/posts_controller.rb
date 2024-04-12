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
    redirect_back(fallback_location: posts_path)
  end

  def unlike
    @post = Post.find(params[:id])
    @post.likes.find_by(user_id: current_user.id).destroy
    redirect_back(fallback_location: posts_path)
  end

  def likes
    @post = Post.find(params[:id])
    @post_like = @post.likes.includes(:user).all
  end

  private
    def post_params
      params.require(:post).permit(:body,:photo)
    end
end
