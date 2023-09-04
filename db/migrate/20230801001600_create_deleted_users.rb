class CreateDeletedUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :deleted_users do |t|
      t.string :username

      t.timestamps
    end
  end
end
