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

  it "answers a survey question", :vcr do
    survey = Poptart::Survey.create_random
    survey_question = survey.survey_questions.first
    survey_question.text.should be
    survey_question.answer = "foo"
    survey_question.submit.should be

    survey = Poptart::Survey.for_id(survey.id)
    survey.survey_questions.first.answer.should == "foo"
  end

  it "answers a survey question", :vcr do
    boolean_questions = Poptart::Question.all(type: 'boolean')
    survey = Poptart::Survey.create
    survey.add_question(boolean_questions.first).should be

    survey = Poptart::Survey.for_id(survey.id)
    survey.survey_questions.count.should == 1
    survey_question = survey.survey_questions.first
    survey_question.responses.should == ['t', 'f']
    survey_question.type.should == 'boolean'

    survey_question.answer = 'true'
    survey_question.submit.should be

    survey = Poptart::Survey.for_id(survey.id)
    survey.survey_questions.first.answer.should == 'true'
  end

  it "finds survey question for id", :vcr do
    survey = Poptart::Survey.create_random
    first_survey_question = survey.survey_questions.first
    survey_question = survey.survey_question_for_id(first_survey_question.id)
    first_survey_question.should == survey_question
  end
end


