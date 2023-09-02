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
  
  # Post relationship
  has_many :posts
  def posts_number
    posts.count
  end

  has_many :comments

  # Follows
  has_many :follower_records, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_records, source: :follower
  
  has_many :following_records, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followings, through: :following_records, source: :following

  def follows?(user)
    return following_records.exists?(following: user)
  end
  
  has_many :shared_posts_relation, class_name: 'SharedPost', foreign_key: :user_id
  has_many :shared_posts, through: :shared_posts_relation, source: :post
  # Likes relationship
  has_many :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
