# frozen_string_literal: true

# Posts migration
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :content

      t.references :user, null: false, foreign_key: true

      t.references :parent, foreign_key: { to_table: :posts }
  
      t.timestamps
    end
  end
end
