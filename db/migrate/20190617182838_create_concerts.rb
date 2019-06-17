class CreateConcerts < ActiveRecord::Migration[5.2]
  def change
    create_table :concerts do |t|
      t.integer :artist_id
      t.integer :venue_id
      t.date :date
      t.decimal :min_price
      t.decimal :max_price
    end
  end
end
