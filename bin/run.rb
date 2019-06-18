require_relative "../config/environment"
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

cli = CommandLineInterface.new
cli.greet
cli.login_or_create_account
