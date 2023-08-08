# frozen_string_literal: true

# Post model
class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  has_many_attached :images
  # Likes relationship
  has_many :likes
end
