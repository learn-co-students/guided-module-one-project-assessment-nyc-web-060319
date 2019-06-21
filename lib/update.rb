require_relative "generics.rb"

class Updater
    include Interactor
    def initialize(enable_translation = false)
        @translation_enabled = enable_translation
    end

    def talk_to_user
        puts "what question do you want to update the answer for?"
        # Rake brakes bare gets, must explicitly use STDIN.gets
        question_to_update_user_entry = STDIN.gets.chomp.downcase
        question = Question.find_by(:question => question_to_update_user_entry)
        if question == nil
            puts "#{question_to_update_user_entry} not found!"
            return
        end
        puts "what do you want the new answer to be?"
        new_answer_text = STDIN.gets.chomp.downcase
        new_answer = Answer.find_or_create_by(:answer => new_answer_text)
        qa = QuestionAnswer.find_by(:question => question)
        qa.destroy
        QuestionAnswer.find_or_create_by(:answer => new_answer, :question => question)
    end
end