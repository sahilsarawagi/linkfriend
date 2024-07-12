module NotificationsHelper
  def user_notifications
    if current_user
      current_user.notifications.leatest.unviewed
    else
      []
    end
  end
end
