class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(receiver_id: current_user.id).order(created_at: :desc)
  end

  def update
    notification = Notification.find_by(id: params[:id])
    notification.mark_as_read

    puts notification.notifiable_type

    case notification.notifiable_type
    when 'Like'
      redirect_to post_path(notification.notifiable.post)
    when 'Post'
      redirect_to post_path(notification.notifiable)
    when'SharedPost'
      redirect_to post_path(notification.notifiable.post)
    when 'Follow'
      redirect_to user_path(notification.notifiable.follower)
    end

  end

end
