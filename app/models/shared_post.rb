class SharedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :notifications, as: :notifiable
end
