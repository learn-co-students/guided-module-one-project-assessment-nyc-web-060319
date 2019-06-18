class Question < ActiveRecord::Base
    has_many :question_answers
    has_many :answers, through: :question_answers

    def response
        # binding.pry
        # found_qa = self.question_answers.find_by(:question => self)
        found_qa = self.question_answers.where(:question => self)
        # binding.pry
        if found_qa.length == 0
            ans = nil
        else
            ans = Answer.find_by(id: found_qa.sample.answer_id)
        end
        ans
    end

end

