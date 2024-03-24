class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @post = Post.new
    @posts = Post.includes(:user).all
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
  private
    def post_params
      params.require(:post).permit(:body)
    end
end