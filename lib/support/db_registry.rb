require 'ostruct'
require_relative "./connection_adapter"

DBRegistry ||= OpenStruct.new(test: ConnectionAdapter.new("db/chatbot-test.db"), 
  development: ConnectionAdapter.new("db/chatbot-development.db"), 
  production: ConnectionAdapter.new("db/chatbot-production.db")
  )
