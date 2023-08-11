# frozen_string_literal: true

# User model
class User < ApplicationRecord
  # Add fields to User model
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :is_verified, inclusion: { in: [true, false] }

  # Configured 'avatar' and 'banner' as Active Storage attachments
  has_one_attached :avatar
  has_one_attached :banner
  
  has_many :posts
  has_many :comments
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following_users, foreign_key: :following_id, class_name: 'Follow'
  has_many :followings, through: :followed_users, source: :following
  has_many :followers, through: :following_users, source: :follower
  has_many :shared_posts_relation, class_name: 'SharedPost', foreign_key: :user_id
  has_many :shared_posts, through: :shared_posts_relation, source: :post
  # Likes relationship
  has_many :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
