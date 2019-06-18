# NOT named learn.rb because of the learn.co suite!
require_relative "../config/environment"

class Learner

    def question_text
        puts "Question text:"
        question = STDIN.gets.chomp
        puts "Response text:"
        response = STDIN.gets.chomp
        new_question = Question.find_or_create_by(:question => question)
        new_answer = Answer.find_or_create_by(:answer=> response)
        qa = QuestionAnswer.find_or_create_by(:answer=> new_answer, :question => new_question)
        binding.pry
    end

    def learn_loop
        while(true) do
            question_text
        end
    end

    def run
        begin
            puts "Beginning learn mode..."
            puts "control + c to exit."
            learn_loop
        rescue Interrupt => e
            puts "ok, done with learn mode."
            return
        end
    end
end