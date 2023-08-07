# frozen_string_literal: true

# Change field name in table post
class ChangeFieldNameInTablePost < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :context, :content
  end
end
