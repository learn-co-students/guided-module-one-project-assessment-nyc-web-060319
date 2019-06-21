class CreateAnswer < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :answer
    end
  end
end
