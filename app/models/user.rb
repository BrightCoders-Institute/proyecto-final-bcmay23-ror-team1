# frozen_string_literal: true

class User < ApplicationRecord
  # Add fields to User model
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :is_verified, inclusion: { in: [true, false] }

  # Configured 'avatar' and 'banner' as Active Storage attachments
  has_one_attached :avatar
  has_one_attached :banner

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following_users, foreign_key: :following_id, class_name: 'Follow'
  has_many :followings, through: :followed_users, source: :following
  has_many :followers, through: :following_users, source: :follower

  # Likes relationship
  has_many :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
