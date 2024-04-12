class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    redirect_back(fallback_location: users_path)
  end
  
  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: users_path)
  end

  def followers
    @user = User.find(params[:id])
    @user_followers = @user.followers
  end

  def followings
    @user = User.find(params[:id])
    @user_followings = @user.followees
  end

end

