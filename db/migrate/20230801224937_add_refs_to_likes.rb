# frozen_string_literal: true

# Add refs to likes
class AddRefsToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :post, null: false, foreign_key: true
    add_reference :likes, :user, null: false, foreign_key: true
  end
end
