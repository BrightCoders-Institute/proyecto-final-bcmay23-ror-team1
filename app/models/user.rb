class User < ApplicationRecord
  # Add fields to User model
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :is_verified, inclusion: { in: [true, false] }

  # Configured 'avatar' and 'banner' as Active Storage attachments
  has_one_attached :avatar
  has_one_attached :banner

  has_many :shared_posts_relation, class_name: 'SharedPost', foreign_key: :user_id
  has_many :shared_posts, through: :shared_posts_relation, source: :post

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
