class RemoveUserColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :venues, :user_id
    remove_column :concerts, :user_id
    remove_column :artists, :user_id
  end
end
