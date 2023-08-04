class Post < ApplicationRecord
  validates :content, presence: true

  belongs_to :user

  has_many_attached :images
  
  has_many :shared_posts_relation, class_name: 'SharedPost', foreign_key: :post_id
  has_many :sharers, through: :shared_posts_relation, source: :user
end
