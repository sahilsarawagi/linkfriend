class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    html = ApplicationController.render(partial: 'shared/notification',locals: {notification: notification})
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", {html: html}
    rescue => e
    Rails.logger.error "Failed to broadcast notification: #{e.message}"
  end
end
