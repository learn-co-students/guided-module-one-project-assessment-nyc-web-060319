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
    "what's your name",#all after this point
    "whats your favorite color?",
    "What happens when an elephant sees a kanagroo?",
    "When teachers are gone, what should we do?",
    "Red or blue you choose",
    "Seed data for a seed"
]

A_STRINGS = [
	"Yes",
	"Sounds like a great idea",
	"I am great thanks",
	"Nothing much what are you up to",
	"call 1-213-373-4253",
	"Really is this the best we can do?",
	"Good evening thank you for calling flatiron how may I direct your call today?",
	"Have a party!",
	"We are all happy people",
	"The red pill was a mistake he should have taken the blue....",
	"I feel like chicken tonight, like chicken tonight",
    "Another thing to do when done",
    "end of list, yo"
]

13.times do |i|
    q = Question.find_or_create_by(:question => Q_STRINGS[i].downcase)
    a = Answer.find_or_create_by(:answer => A_STRINGS[i].downcase)
    QuestionAnswer.find_or_create_by(:answer => a, :question => q)
end