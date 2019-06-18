# if ENV["CHATBOT_ENV"] != "test"
#     puts "Will not seed the production/development database!!!"
#     raise StandardError, "No."
# end
ENV["CHATBOT_ENV"] ||= "development"

require_relative "../config/environment.rb"
# require_relative "../app/models/question.rb"
# require_relative "../app/models/answer.rb"
# require_relative "../app/models/question_answer.rb"



Q_STRINGS = [
    "hey",
    "hello",
    "bye",
    "how are you",
    "what's up",
    "why",
    "bad",
    "what's your name"
]

8.times do |i|
    q = Question.find_or_create_by(:question => Q_STRINGS[i])
    a = Answer.find_or_create_by(:answer => "`#{Q_STRINGS[i]}`? Ok, go on...")
    QuestionAnswer.find_or_create_by(:answer => a, :question => q)
end