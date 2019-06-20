require_relative "learn_interactor_class.rb"
require_relative "speak.rb"
require_relative "cloud/google_translate_api.rb"

def instructions
    puts <<-HELP
Hello! welcome to the chatbot!
Whats up? Enter a command:
\t(l)earn
\t(s)peak
\t(q)uit
\t(u)pdate
\t(d)elete
\tenable (t)ranslation
HELP
end

def validate(response)
    # binding.pry
    if !response.start_with?(*(COMMANDS_SHORT.values))
        puts "invalid command"
        query_user
    end
end


COMMANDS_SHORT = {learn: "l", speak: "s", quit: "q", update: "u", delete: "d", translate: "t" }

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
    elsif response.start_with?(COMMANDS_SHORT[:translate])
        return :translate
    end
end


class Runner
    @@translator_target_language = ""
    def learner
        learn = Learner.new
        learn.run
    end

    def speaker
        speak = Speaker.new(enable_translation: @@translator_target_language != "", translator_target_language: @@translator_target_language)
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

    def translate_config
        supported_languages = Translator::get_languages
        puts "Supported language codes:"
        supported_languages.each do |language|
            puts language.code
        end
        puts "NONE to disable"
        user_response_text = STDIN.gets.chomp.downcase
        if user_response_text == "NONE"
            @@translator_target_language = ""
        else
            found_response_code = supported_languages.find{|language| language.code == user_response_text}
            @@translator_target_language = found_response_code.code
        end
        # binding.pry
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
        elsif command == :translate
            translate_config
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