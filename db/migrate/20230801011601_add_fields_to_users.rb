class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :is_verified, :boolean, default: false
    add_column :users, :biography, :text

    # Add avatar and banner with Active Storage
    add_reference :users, :avatar, foreign_key: { to_table: :active_storage_attachments }
    add_reference :users, :banner, foreign_key: { to_table: :active_storage_attachments }
  end
end
