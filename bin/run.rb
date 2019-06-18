require_relative "../config/environment"
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

# puts "hello world"
cli = CommandLineInterface.new
# cli.greet
# cli.login_or_create_account

cli.find_concert
