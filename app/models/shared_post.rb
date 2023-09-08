class SharedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :notifications, as: :notifiable
  
  after_save :create_notification

  private
  
  def create_notification
    Notification.create(
      message: "shared your post",
      sender_id: self.user_id,
      receiver_id: self.post.user_id,
      notifiable_id: self.id,
      notifiable_type: "SharedPost"
    )
  end

end
