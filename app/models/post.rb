# frozen_string_literal: true

# Post model
class Post < ApplicationRecord
  validates :content, presence: true

  belongs_to :user

  has_many_attached :images
  has_many :shared_posts_relation, class_name: 'SharedPost', foreign_key: :post_id
  has_many :sharers, through: :shared_posts_relation, source: :user
  
 
  has_many :likes

  # Associate a post as to a parent post
  # this allows to treat it as a comment when needed
  belongs_to :parent, class_name: 'Post', optional: true

  # Get the posts that belongs to another post
  scope :comments, ->(post) { where(parent_id: post.id) }

  # Recursivelly calls all the parents/ancestors
  scope :ancestors, ->(post, ancestors_list) {
    if post.parent.nil?
      return ancestors_list
    else
      ancestors_list.unshift(post.parent)
    end
    ancestors(post.parent, ancestors_list)
  }

end
