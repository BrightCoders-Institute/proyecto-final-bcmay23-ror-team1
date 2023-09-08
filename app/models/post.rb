# frozen_string_literal: true

# Post model
class Post < ApplicationRecord
  validates :content, presence: true

  belongs_to :user, optional: true
  belongs_to :deleted_user, optional: true

  has_many_attached :images
  has_many :shared_posts_relation, class_name: 'SharedPost', foreign_key: :post_id
  has_many :sharers, through: :shared_posts_relation, source: :user
  
 
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def unliked_by(user)
    likes.find_by(user_id: user.id).destroy
  end

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

  def swap_to_deleted_user(deleted_id)
    self.user_id = nil
    self.deleted_user_id = deleted_id
    save
  end

  has_many :notifications, as: :notifiable
  
  after_save :create_notification

  private
  
  def create_notification
    if self.parent.present? && self.user_id != self.parent.user_id
      Notification.create(
        sender_id: self.user_id,
        receiver_id: self.parent.user_id,
        notifiable_id: self.id,
        notifiable_type: "Post"
      )
    end
  end
end
