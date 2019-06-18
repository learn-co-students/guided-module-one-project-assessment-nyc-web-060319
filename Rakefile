ENV["CHATBOT_ENV"] ||= "development"

require_relative 'config/environment'
require 'sinatra/activerecord/rake'
require_relative "bin/run.rb"

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end


desc 'runs app'
task :run_main do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  main
end

