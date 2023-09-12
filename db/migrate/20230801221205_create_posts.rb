# frozen_string_literal: true

# Posts migration
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :content

      t.references :user, null: true, foreign_key: true
      t.references :deleted_user, null: true, foreign_key: true

      t.references :parent, foreign_key: { to_table: :posts }

      t.boolean :deleted, null: false, default: false
  
      t.timestamps
    end
  end
end
