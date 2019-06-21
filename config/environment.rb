require 'bundler'
Bundler.require

require 'sinatra/activerecord/rake'


Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}

ENV["CHATBOT_ENV"] ||= "development"
ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "/Users/flatironschool/.keys/API Project-d0d51d49d2b7.json"

# binding.pry
DBRegistry[ENV["CHATBOT_ENV"]].connect!
DB = ActiveRecord::Base.connection

# ActiveRecord::Base.establish_connection(adapter: 'sqlfite3', database: 'db/development.db')
require_all 'lib'

if ENV["ACTIVE_RECORD_ENV"] == "test"
    ActiveRecord::Migration.verbose = false
end
  