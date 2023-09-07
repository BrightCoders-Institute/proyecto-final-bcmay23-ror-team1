class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :message
      t.boolean :read
      
      t.integer :sender_id 
      t.integer :receiver_id
      
      t.integer :notifiable_id
      t.string :notifiable_type
      
      t.timestamps
    end
    add_index :notifications, [:notifiable_type, :notifiable_id]
  end
end
