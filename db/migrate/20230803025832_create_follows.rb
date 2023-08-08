# frozen_string_literal: true

# Follows migration
class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps
    end
  end
end
