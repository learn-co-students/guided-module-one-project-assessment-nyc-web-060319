class Question < ActiveRecord::Base
    has_many :question_answers
    has_many :answers, through: :question_answers

    def response
        # binding.pry
        found_qa = QuestionAnswer.find_by(question_id: self.id)
        if found_qa == nil
            binding.pry
            return "Oh, that's neat."
        end
        ans = Answer.find_by(id: found_qa.answer_id)
        ans.response
    end

end

