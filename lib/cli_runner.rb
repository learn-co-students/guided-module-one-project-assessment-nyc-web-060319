require_relative "learn_interactor_class.rb"
require_relative "speak.rb"

def instructions
    puts "Hello! welcome to the chatbot!"
    puts "Whats up? Enter a command:"
    puts "\t(l)earn"
    puts "\t(s)peak"
    puts "\t(q)uit"
    puts "\t(u)pdate"
    puts "\t(d)elete"
end

class Runner
    COMMANDS_SHORT = {learn: "l", speak: "s", quit: "q", update: "u", delete: "d"}
 
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
        elsif response.start_with?(COMMANDS_SHORT[:update])
            return :update
        elsif response.start_with?(COMMANDS_SHORT[:delete])
            return :delete
        elsif response.start_with?(COMMANDS_SHORT[:quit])
            puts "buh bye!"
            exit
        end
    end

    def learner
        learn = Learner.new
        learn.run
    end

    def speaker
        speak = Speaker.new
        speak.run
    end
    
    def updater
        update = Updater.new
        update.run
    end

    def deleter
        delete = Deleter.new
        delete.run
    end

    def dispatch(command)
        # binding.pry
        if command == :learn
            learner
        elsif command == :speak
            speaker
        elsif command == :update
            updater
        elsif command == :delete
            deleter
        else
            # shouldn't reach
            abort
        end
    end


    def run()
        while(true) do
            instruction = query_user
            dispatch(instruction)
        end
    end
end