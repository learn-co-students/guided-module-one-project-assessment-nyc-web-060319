require_relative "config/environment"
require "sinatra/activerecord/rake"

desc "starts a console"
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

desc "seed database with faker data"
task :seed do
  ruby seed.rb
end
