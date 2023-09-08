# frozen_string_literal: true

# Like model
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }

  has_many :notifications, as: :notifiable

  after_save :create_notification

  private
  
  def create_notification
    Notification.create(
      message: "liked your post",
      sender_id: self.user_id,
      receiver_id: self.post.user_id,
      notifiable_id: self.id,
      notifiable_type: "Like"
    )
  end
    
end
