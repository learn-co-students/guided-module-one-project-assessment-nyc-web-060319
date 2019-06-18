# NOT named learn.rb because of the learn.co suite!
# require_relative "../config/environment"
require_relative "generics.rb"

class Learner
    include Interactor
    def talk_to_user
        puts "Question text:"
        question = STDIN.gets.chomp
        puts "Response text:"
        response = STDIN.gets.chomp
        new_question = Question.find_or_create_by(:question => question)
        new_answer = Answer.find_or_create_by(:answer=> response)
        QuestionAnswer.find_or_create_by(:answer=> new_answer, :question => new_question)
        # binding.pry
    end

end