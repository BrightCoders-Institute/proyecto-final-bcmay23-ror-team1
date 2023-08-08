# frozen_string_literal: true

# Add user reference to post
class AddUserReferenceToPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
