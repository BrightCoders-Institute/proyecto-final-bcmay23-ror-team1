class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(receiver_id: current_user.id).order(created_at: :desc)
  end
end
