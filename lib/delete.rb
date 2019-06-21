require_relative "generics.rb"

class Deleter
    include Interactor
    def initialize(enable_translation = false)
        @translation_enabled = enable_translation
    end

    def talk_to_user
        puts "what question do you want to remove from the database?"
        # Rake brakes bare gets, must explicitly use STDIN.gets
        question_input = STDIN.gets.chomp
        question = Question.find_by(:question => question_input)
        if question == nil
            puts "#{question_input} not found!"
            return
        end
        # question_answers.find_by(:question => self)
        qa = QuestionAnswer.find_by(:question => question)
        question.destroy
        qa.destroy
    end
end