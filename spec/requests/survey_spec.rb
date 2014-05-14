require 'spec_helper'

describe Poptart::Survey do
  it "creates and returns an empty survey", :vcr do
    survey = Poptart::Survey.create
    survey.survey_questions.count.should == 0
  end

  it "creates and returns a random question survey", :vcr do
    survey = Poptart::Survey.create_random
    survey.survey_questions.count.should == 5
  end

  it "answers a boolean question", :vcr do
    boolean_questions = Poptart::BooleanQuestion.all
    survey = Poptart::Survey.create
    survey.add_question(boolean_questions.first).should be

    survey = Poptart::Survey.for_id(survey.id)
    survey.survey_questions.count.should == 1
    survey_question = survey.survey_questions.first
    survey_question.type.should == "BooleanQuestion"

    survey_question.answer = true
    survey_question.submit.should be

    survey = Poptart::Survey.for_id(survey.id)
    survey.survey_questions.first.answer.should == true
  end

  it "returns a multiple response question", :vcr, record: :all do
    questions = Poptart::MultipleResponseQuestion.all
    survey = Poptart::Survey.create
    survey.add_question(questions.first).should be
    binding.pry

    survey = Poptart::Survey.for_id(survey.id)
    survey.survey_questions.count.should == 1
    survey_question = survey.survey_questions.first
    survey_question.type.should == "MultipleResponseQuestion"

    last_response = survey_question.responses.last
    survey_question.answer = last_response
    survey_question.submit.should be

    survey = Poptart::Survey.for_id(survey.id)
    survey.survey_questions.first.answer.should == last_response
  end

  it "returns a range question"

  it "returns a time range question"
end


