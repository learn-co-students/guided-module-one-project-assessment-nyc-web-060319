if ENV["CHATBOT_ENV"] != "test"
    puts "Will not seed the production/development database!!!"
    raise StandardError, "No."
end

