# frozen_string_literal: true

# Posts migration
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :context

      t.timestamps
    end
  end
end
