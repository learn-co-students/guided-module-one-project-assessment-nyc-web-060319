require_relative "../config/environment"

puts "hello world"
cli = CommandLineInterface.new
cli.greet
cli.login_or_create_account
