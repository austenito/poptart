require 'spec_helper'

describe 'retrieving answers' do
  it 'returns answers' do
    question = Poptart::BooleanQuestion.create("Do you like poptarts?")
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

  xit "returns all answered survey questions for a question", :vcr, :record => :all do
    questions = Poptart::Question.all(type: 'multiple')
    question = questions.find { |question| question.responses.include?('At Home') }
    user = Poptart::User.create

    survey = user.create_survey
    survey.add_question(question).should be
    second_survey = user.create_survey
    second_survey.add_question(question).should be

    survey = user.survey_for_id(survey.id)
    survey_question = survey.survey_questions.first
    survey_question.answer = 'At Home'
    survey_question.submit.should be

    survey = user.survey_for_id(second_survey.id)
    survey_question = survey.survey_questions.first
    survey_question.answer = 'At Work'
    survey_question.submit.should be

    answered_questions = user.survey_questions_for_question_id(question.id)
    answered_questions.map(&:answer).should =~ ['At Home', 'At Work']
  end
end
