class SharedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post, dependent: :destroy

  has_many :notifications, as: :notifiable, dependent: :destroy
  
  after_save :create_notification

  private
  
  def create_notification
    if self.user_id != self.post.user_id
      Notification.create(
        sender_id: self.user_id,
        receiver_id: self.post.user_id,
        notifiable_id: self.id,
        notifiable_type: "SharedPost"
      )
    end
  end

end
