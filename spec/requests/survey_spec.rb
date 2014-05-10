require 'spec_helper'

describe Poptart::Survey do
  it "creates and returns a survey", :vcr do
    root = Poptart::Root.get_root
    survey = root.create_survey
    survey.survey_questions.count.should == 5
  end

  it "answers a survey question", :vcr, record: :all do
    root = Poptart::Root.get_root
    survey = root.create_survey
    survey_question = survey.survey_questions.first
    survey_question.text.should be
    survey_question.answer = "foo"
    survey_question.submit.should be

    survey = Poptart::Survey.for_id(survey.id)
    survey.survey_questions.first.answer.should == "foo"
  end
end


