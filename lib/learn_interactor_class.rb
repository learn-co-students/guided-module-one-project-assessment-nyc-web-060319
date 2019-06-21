# NOT named learn.rb because of the learn.co suite!
# require_relative "../config/environment"
require_relative "generics.rb"

class Learner
    def initialize(enable_translation = false)
        @translation_enabled = enable_translation
    end

    include Interactor
    def talk_to_user
        puts "Question text:"
        # Rake brakes bare gets, must explicitly use STDIN.gets
        question = STDIN.gets.chomp
        puts "Response text:"
        response = STDIN.gets.chomp
        new_question = Question.find_or_create_by(:question => question)
        new_answer = Answer.find_or_create_by(:answer=> response)
        QuestionAnswer.find_or_create_by(:answer=> new_answer, :question => new_question)
        # binding.pry
    end

end