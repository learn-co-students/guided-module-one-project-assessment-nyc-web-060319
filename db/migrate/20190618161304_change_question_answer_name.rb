class ChangeQuestionAnswerName < ActiveRecord::Migration[5.2]
  def change
    rename_table :question_answer, :question_answers
  end
end
