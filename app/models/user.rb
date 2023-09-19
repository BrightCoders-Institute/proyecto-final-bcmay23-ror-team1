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
  has_many :posts_and_comments, class_name: 'Post' # posts and comments

  def posts
    posts_and_comments.where(parent_id: nil) # posts and shares
  end

  def posts_number
    posts.count + shared_posts_relation.count # only posts
  end

  def comments
    posts_and_comments.where.not(parent_id: nil) # only comments
  end

  # Follow relationship
  has_many :follower_records, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_records, source: :follower
  
  has_many :following_records, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followings, through: :following_records, source: :following

  # check if user is following another user
  def follows?(user)
    return following_records.exists?(following: user)
  end

  #create follow relationship
  def create_follow(user)
    Follow.create(follower: self, following: user);
  end
  
  #destroy follow relationship
  def destroy_follow(user)
    following_records.find_by(following: user).destroy
  end
  
  def followings_number
    followings.count
  end
  def followers_number
    followers.count
  end

  # Shared post relationship
  has_many :shared_posts_relation, class_name: 'SharedPost', foreign_key: :user_id
  has_many :shared_posts, through: :shared_posts_relation, source: :post

  # Likes relationship
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  # returns the date in the format "Joined in January 2021"
  def created_date
    user_created_month_name = created_at.strftime("%B") 
    user_created_year = created_at.strftime("%Y")

    "Joined in #{user_created_month_name} #{user_created_year}"
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def swap_posts_to_deleted_user
    posts.each do |post|
      post.swap_to_deleted_user(id)
    end
  end

  has_many :sent_notifications, foreign_key: :receiver_id, class_name: 'Notification', dependent: :destroy
  has_many :received_notifications, foreign_key: :sender_id, class_name: 'Notification', dependent: :destroy
  
end
