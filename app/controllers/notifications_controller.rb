class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(receiver_id: current_user.id)
  end
end
