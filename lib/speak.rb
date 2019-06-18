# require_relative "../config/environment"

class Speak

    def talk_to_user
        puts "\nWhat say you?"
        user_text = STDIN.gets.chomp.downcase
        user_q = Question.find_or_create_by(question: user_text)
        answer = user_q.response
        if answer != nil
            puts answer.answer
        else
            puts "Go on...\n"
        end
    end

    def speak_loop
        while(true) do
            talk_to_user
        end
    end

    def run
        begin
            puts "Beginning speak mode..."
            puts "control + c to exit."
            speak_loop
        rescue Interrupt => _
            puts "ok, done with speak mode."
            return
        end
    end

end