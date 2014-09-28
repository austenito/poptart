require 'spec_helper'

describe 'retrieving answers' do
  xit 'returns answers', :vcr, record: :all do
    question = Poptart::BooleanQuestion.create(text: text)
    user = Poptart::User.create
    survey = user.create_survey
    survey_question = survey.add_question(question)
    survey_question.answer = true
    survey_question.submit

    second_survey = user.create_survey
    second_survey_question = second_survey.add_question(question)
    second_survey_question.answer = false
    second_survey_question.submit

    answers = question.answers
    answers.first.answer.should == true
    answers.created_at.should_not be_nil

    answers.first.answer.should == false
    answers.last.should_not be_nil
  end
end
