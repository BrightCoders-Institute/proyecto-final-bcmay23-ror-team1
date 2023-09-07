# frozen_string_literal: true

# Follow model
class Follow < ApplicationRecord
  # The user that follows
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'

  # The user that is followed by another
  belongs_to :following, foreign_key: :following_id, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :following_id }

  has_many :notifications, as: :notifiable
end
