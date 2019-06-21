ENV["CHATBOT_ENV"] ||= "development"

require_relative 'config/environment'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  require_relative "bin/run.rb"
  Pry.start
end


desc 'runs app with debug logging'
task :run_debug do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  require_relative "bin/run.rb"
  # main
end

desc 'runs app withOUT debug logging'
task :run do
  # ActiveRecord::Base.logger = Logger.new(STDOUT)
  require_relative "bin/run.rb"
  # main
end

