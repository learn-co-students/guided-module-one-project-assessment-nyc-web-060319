# if ENV["CHATBOT_ENV"] != "test"
#     puts "Will not seed the production/development database!!!"
#     raise StandardError, "No."
# end
require_relative "../app/models/question.rb"
require_relative "../app/models/answer.rb"
require_relative "../app/models/question_answer.rb"

# Thanks https://americanenglish.state.gov/files/ae/resource_files/b_dialogues_everyday_conversations_english_lo_0.pdf
Q_STRINGS = [
    "good morning",
    "hello",
    "nice to meet you",
    "how's it going?",
    "where are you off too?",

    "how are you?",
    "thank you"
]

A_STRINGS = [
    "Good morning!",
    "Hey!",
    "Nice to meet you too!",
    "Fine, thanks!",
    "The library",

    "Good, I was just thinking about you!",
    "You're welcome."
]


q0 = Question.find_or_create_by(:question => Q_STRINGS[0])
q1 = Question.find_or_create_by(:question => Q_STRINGS[1])
q2 = Question.find_or_create_by(:question => Q_STRINGS[2])
q3 = Question.find_or_create_by(:question => Q_STRINGS[3])
q4 = Question.find_or_create_by(:question => Q_STRINGS[4])

q5 = Question.find_or_create_by(:question => Q_STRINGS[5])
q6 = Question.find_or_create_by(:question => Q_STRINGS[6])
q7 = Question.find_or_create_by(:question => Q_STRINGS[7])
q8 = Question.find_or_create_by(:question => Q_STRINGS[8])
q9 = Question.find_or_create_by(:question => Q_STRINGS[9])


a0 = Answer.find_or_create_by(:answer => A_STRINGS[0])
a1 = Answer.find_or_create_by(:answer => A_STRINGS[1])
a2 = Answer.find_or_create_by(:answer => A_STRINGS[2])
a3 = Answer.find_or_create_by(:answer => A_STRINGS[3])
a4 = Answer.find_or_create_by(:answer => A_STRINGS[4])
a5 = Answer.find_or_create_by(:answer => A_STRINGS[5])
a6 = Answer.find_or_create_by(:answer => A_STRINGS[6])
a7 = Answer.find_or_create_by(:answer => A_STRINGS[7])
a8 = Answer.find_or_create_by(:answer => A_STRINGS[8])
a9 = Answer.find_or_create_by(:answer => A_STRINGS[9])

QuestionAnswer.find_or_create_by( :answer => a0, :question =>q0 )
QuestionAnswer.find_or_create_by( :answer => a1, :question =>q1 )
QuestionAnswer.find_or_create_by( :answer => a2, :question =>q2 )
QuestionAnswer.find_or_create_by( :answer => a3, :question =>q3 )
QuestionAnswer.find_or_create_by( :answer => a4, :question =>q4 )

QuestionAnswer.find_or_create_by( :answer => a5, :question =>q5 )
QuestionAnswer.find_or_create_by( :answer => a6, :question =>q6 )
QuestionAnswer.find_or_create_by( :answer => a7, :question =>q7 )
QuestionAnswer.find_or_create_by( :answer => a8, :question =>q8 )
QuestionAnswer.find_or_create_by( :answer => a9, :question =>q9 )
binding.pry