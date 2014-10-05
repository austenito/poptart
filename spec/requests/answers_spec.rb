require 'spec_helper'

describe 'retrieving answers' do
  it "returns all answered survey questions for a question", :vcr do
    question = Poptart::BooleanQuestion.create("Do you like poptarts?")
    user = Poptart::User.create

    survey = user.create_survey
    first_survey_question = survey.add_question(question)
    second_survey = user.create_survey
    second_survey_question = second_survey.add_question(question)

    first_survey_question.answer = true
    first_survey_question.submit.should be

    second_survey_question.answer = false
    second_survey_question.submit.should be

    survey_questions = user.survey_questions_for_question_id(question.id)
    survey_questions.map(&:answer).should =~ [true, false]
  end
end
