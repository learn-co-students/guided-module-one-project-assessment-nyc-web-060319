class CreateQuestionAnswer < ActiveRecord::Migration[5.2]
  def change
    create_table :question_answer do |t|
      t.integer :question_id
      t.integer :answer_id
    end
  end
end
