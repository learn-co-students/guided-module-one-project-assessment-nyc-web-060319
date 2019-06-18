class CreateUserConcerts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_concerts do |t|
      t.integer :user_id
      t.integer :concert_id
    end
  end
end
