require 'spec_helper'

describe 'Answering survey questions', :vcr do
  it "creates and returns an empty survey" do
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    survey = Poptart::Survey.create
    expect(survey.service_user_id).to eq(user.service_user_id)
    expect(survey.survey_questions.count).to eq(0)
  end

  it "answers a survey question" do
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    survey = Poptart::Survey.create

    question = Poptart::Question.create(
      'Do you like poptarts?',
      responses: [true, false],
      question_type: 'boolean'
    )
    survey_question = Poptart::SurveyQuestion.new('question_id' => question.id)
    survey_question = survey.add_survey_question(survey_question)

    expect(survey.survey_questions.count).to eq(1)
    expect(survey_question.responses).to eq(['t', 'f'])
    expect(survey_question.question_type).to eq('boolean')

    survey_question.answer = true
    expect(survey_question.submit).to eq(true)

    survey = Poptart::Survey.find(survey.id)
    expect(survey.survey_questions.first.answer).to eq(true)
    expect(survey.completed?).to eq(true)
  end

  it "answers a multiple choice question" do
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    survey = Poptart::Survey.create

    question = Poptart::Question.create(
      'Where are you?',
      responses: ["At Home", "At Work", "In a car", "Other"],
      question_type: 'multiple'
    )
    survey_question = Poptart::SurveyQuestion.new('question_id' => question.id)
    survey_question = survey.add_survey_question(survey_question)

    expect(survey.survey_questions.count).to eq(1)
    expect(survey_question.responses).to eq(["At Home", "At Work", "In a car", "Other"])
    expect(survey_question.question_type).to eq('multiple')

    survey_question.answer = 'At Home'
    expect(survey_question.submit).to be

    survey = Poptart::Survey.find(survey.id)
    expect(survey.survey_questions.first.answer).to eq('At Home')
  end

  it "finds survey question for id" do
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    questions = Poptart::Question.all(type: 'multiple')
    survey = Poptart::Survey.create

    question = Poptart::Question.create(
      'Where are you?',
      responses: ["At Home", "At Work", "In a car", "Other"],
      question_type: 'multiple'
    )
    survey_question = Poptart::SurveyQuestion.new('question_id' => question.id)
    first_survey_question = survey.add_survey_question(survey_question)
    second_survey_question = survey.add_survey_question(survey_question)

    survey_question = survey.survey_question_for_id(first_survey_question.id)
    expect(first_survey_question).to eq(survey.survey_question_for_id(first_survey_question.id))
    expect(second_survey_question).to eq(survey.survey_question_for_id(second_survey_question.id))
  end
end
