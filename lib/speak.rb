# require_relative "../config/environment"
require_relative "generics.rb"

class Speaker
    include Interactor

    def initialize(enable_translation = false)
        @translation_enabled = enable_translation
        if @translation_enabled
            @translator = Translator.new("fr")
        end
    end

    def talk_to_user
        puts "\nWhat say you?\n"
        # Rake brakes bare gets, must explicitly use STDIN.gets
        user_text = STDIN.gets.chomp.downcase
        # binding.pry
        user_q = Question.find_or_create_by(question: user_text)
        answer = user_q.response
        if answer != nil
            # binding.pry
            answer = (@translation_enabled && @translator.translate_text(user_q.response))
            # binding.pry
            puts answer
        else
            puts "Go on...\n"
        end
    end

end