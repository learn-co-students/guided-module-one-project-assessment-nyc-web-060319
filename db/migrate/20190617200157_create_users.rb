class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
    end
    add_column :artists, :user_id, :integer
    add_column :concerts, :user_id, :integer
    add_column :venues, :user_id, :integer
  end
end
