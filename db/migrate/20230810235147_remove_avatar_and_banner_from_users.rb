class RemoveAvatarAndBannerFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :avatar_id, :references
    remove_column :users, :banner_id, :references
  end
end
