class Question < ActiveRecord::Base
    has_many :question_answers
    has_many :answers, through: :question_answers

    def response
        binding.pry
        found_qa = self.question_answers.find_by(:question => self)
        ans = Answer.find_by(id: found_qa.answer_id)
        ans
    end

end

