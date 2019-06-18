# require_relative "../config/environment"
require_relative "generics.rb"

class Speaker
    include Interactor

    def talk_to_user
        puts "\nWhat say you?"
        user_text = STDIN.gets.chomp.downcase
        # binding.pry
        user_q = Question.find_or_create_by(question: user_text)
        answer = user_q.response
        if answer != nil
            puts answer.answer
        else
            puts "Go on...\n"
        end
    end

end