class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :message, null: false
      t.boolean :read, null: false, default: false
      
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      
      t.integer :notifiable_id, null: false
      t.string :notifiable_type, null: false
      
      t.timestamps
    end
    add_index :notifications, [:notifiable_type, :notifiable_id]
  end
end
