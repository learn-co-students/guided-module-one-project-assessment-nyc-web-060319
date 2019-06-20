require_relative '../config/environment'
require_relative '../lib/cli_runner.rb'


def main
    a = Artii::Base.new
    ascii_art = a.asciify("Chatbot")
    puts ascii_art
    runner = Runner.new
    runner.run()
end

main
