class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @pending_request_users = user_follower(Follow.follower_list(current_user.id, true))
    @sent_request_users = user_followee(Follow.followee_list(current_user.id, true))
  end

  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.order(created_at: :desc).order('comments.created_at DESC').includes(:user, :comments, :likes)
    @comment = Comment.new
    @requested_pending_status = Follow.pending_field(current_user.id,@user.id)&.pending
    @pending_request_status = Follow.pending_field(@user.id,current_user.id)&.pending
    @user_followers_count = Follow.follower_list(@user.id, false).count
    @user_followings_count = Follow.followee_list(@user.id, false).count
  end

  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    requested_pending_field = Follow.pending_field(current_user.id,@user.id)
    requested_pending_field.pending = true
    requested_pending_field.save
    Notification.create( recipient: @user,
                          actor_id: current_user.id,
                          action: "requested to follow you",
                          notifiable: current_user
                        )
    update_follow_button(@user)
  end
  
  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    update_follow_button(@user)
  end

  def followers
    @user = User.find(params[:id])
    @user_followers = user_follower(Follow.follower_list(@user.id, false))
  end

  def followings
    @user = User.find(params[:id])
    @user_followings = user_followee(Follow.followee_list(@user.id, false))
  end

  def accept_request
    user = User.find(params[:id])
    pending_request_field = Follow.pending_field(user.id,current_user.id)
    pending_request_field.pending =  false
    pending_request_field.save
    Notification.create( recipient: user,
                         actor_id: current_user.id,
                         action: "accepted your follow request",
                         notifiable: current_user
                        )
    update_follow_button(user)
  end

  def cancel_request
    user = User.find(params[:id])
    pending_request_field = Follow.pending_field(user.id,current_user.id)
    pending_request_field.destroy
    update_follow_button(user)
  end

  private

  def user_follower(follower_list)
    follower_list.map(&:follower)
  end

  def user_followee(followee_list)
    followee_list.map(&:followee)
  end

  def update_follow_button(user)
    render turbo_stream:
          turbo_stream.replace( "follow_button_#{user.id}",
            partial: "shared/user_list",
            locals:{user: user}
          )
  end
end

