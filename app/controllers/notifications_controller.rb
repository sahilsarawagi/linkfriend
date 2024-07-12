class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show]

  def show
    @notification.update(viewed: true)
    respond_to do |format|
      format.html { redirect_to notification_target_path(@notification) }
      format.js   # Create a show.js.erb file for AJAX handling
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_target_path(notification)
    case notification.notifiable_type
    when 'Post'
      post_path(notification.notifiable)
    when 'Comment'
      post_path(notification.notifiable.post) 
    when 'User'
      user_path(notification.notifiable)
    else
      root_path
    end
  end
end
