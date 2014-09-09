require 'spec_helper'

describe 'Answering survey questions', :vcr do
  it "creates and returns an empty survey", :vcr do
    user = Poptart::User.create(42)
    survey = user.create_survey
    survey.user_id.should == user.id
    survey.survey_questions.count.should == 0
  end

  it "creates and returns a random question survey", :vcr do
    user = Poptart::User.create(42)
    survey = user.create_random_survey
    survey.user_id.should == user.id
    survey.survey_questions.count.should == 6
  end

  it "answers a survey question", :vcr do
    user = Poptart::User.create(42)
    survey = user.create_random_survey
    survey_question = survey.survey_questions.first
    survey_question.text.should be
    survey_question.answer = "foo"
    survey_question.submit.should be

    survey = user.survey_for_id(survey.id)
    survey.survey_questions.first.answer.should == "foo"
  end

  it "answers a survey question", :vcr do
    boolean_questions = Poptart::Question.all(type: 'boolean')
    user = Poptart::User.create(42)
    survey = user.create_survey
    survey.add_question(boolean_questions.first).should be

    survey = user.survey_for_id(survey.id)
    survey.survey_questions.count.should == 1
    survey_question = survey.survey_questions.first
    survey_question.responses.should == ['t', 'f']
    survey_question.type.should == 'boolean'

    survey_question.answer = 'true'
    survey_question.submit.should be

    survey = user.survey_for_id(survey.id)
    survey.survey_questions.first.answer.should == 'true'
  end

  it "answers a multiple choice question", :vcr do
    questions = Poptart::Question.all(type: 'multiple')
    question = questions.find { |question| question.responses.include?('At Home') }
    user = Poptart::User.create(42)
    survey = user.create_survey
    survey.add_question(question).should be

    survey = user.survey_for_id(survey.id)
    survey.survey_questions.count.should == 1
    survey_question = survey.survey_questions.first
    survey_question.responses.should == ["At Home", "At Work", "In a car", "Other"]
    survey_question.type.should == 'multiple'

    survey_question.answer = 'At Home'
    survey_question.submit.should be

    survey = user.survey_for_id(survey.id)
    survey.survey_questions.first.answer.should == 'At Home'
  end

  it "finds survey question for id", :vcr do
    user = Poptart::User.create(42)
    survey = user.create_random_survey
    first_survey_question = survey.survey_questions.first
    survey_question = survey.survey_question_for_id(first_survey_question.id)
    first_survey_question.should == survey_question
  end
end
