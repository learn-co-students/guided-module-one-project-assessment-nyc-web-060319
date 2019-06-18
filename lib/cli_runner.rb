require_relative "learn_interactor_class.rb"

def instructions
    puts "Hello! welcome to the chatbot!"
    puts "Whats up? Enter a command:"
    puts "\t(l)earn"
    puts "\t(s)peak"
    puts "\t(q)uit"
end

class Runner
    COMMANDS_SHORT = {learn: "l", speak: "s", quit: "q"}
 
    def validate(response)
        # binding.pry
        if !response.start_with?(*(COMMANDS_SHORT.values))
            puts "invalid command"
            query_user
        end
    end

    def query_user
        instructions
        # Rake brakes bare gets, must explicitly use STDIN.gets
        response = STDIN.gets.chomp.downcase
        validate(response)
        if response.start_with?(COMMANDS_SHORT[:learn])
            return :learn
        elsif response.start_with?(COMMANDS_SHORT[:speak])
            return :speak
        elsif response.start_with?(COMMANDS_SHORT[:quit])
            puts "buh bye!"
            exit
        end
    end

    def learner

    end

    def speaker

    end

    def dispatch(command)
        if command == :learn
            learner
        elsif
            speaker
        end
    end


    def run(start = false)
        instruction = query_user
    end
end