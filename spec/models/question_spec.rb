require_relative "../../app/models/question.rb"


# Thank you, https://semaphoreci.com/community/tutorials/how-to-test-rails-models-with-rspec
RSpec.describe Question do
    describe "Associations" do
        it {should have_many(:question_answers)}
    end
end
