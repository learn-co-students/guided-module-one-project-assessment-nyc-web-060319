require_relative "../config/environment"
ActiveRecord::Base.logger = nil

cli = CommandLineInterface.new
# cli.greet
# cli.login_or_create_account
cli.find_concert
