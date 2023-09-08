# frozen_string_literal: true

# Follow model
class Follow < ApplicationRecord
  # The user that follows
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'

  # The user that is followed by another
  belongs_to :following, foreign_key: :following_id, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :following_id }

  has_many :notifications, as: :notifiable

  after_save :create_notification

  private
  
  def create_notification
    Notification.create(
      message: "is following you",
      sender_id: self.follower_id,
      receiver_id: self.following_id,
      notifiable_id: self.id,
      notifiable_type: "Follow"
    )
  end

end
