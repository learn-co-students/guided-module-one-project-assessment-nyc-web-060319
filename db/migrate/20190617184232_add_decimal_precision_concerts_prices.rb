class AddDecimalPrecisionConcertsPrices < ActiveRecord::Migration[5.2]
  def change
    change_column :concerts, :min_price, :decimal, precision: 10, scale: 2
    change_column :concerts, :max_price, :decimal, precision: 10, scale: 2
  end
end
