class Answer < ActiveRecord::Base
    has_many :question_answers
    has_many :questions, thorugh: :question_answers
end
