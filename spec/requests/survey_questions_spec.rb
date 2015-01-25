require 'spec_helper'

describe 'Survey questions', :vcr do
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

  it "returns all answered survey questions for a question", :vcr do
    question = Poptart::Question.create(
      'Do you like poptarts?',
      responses: [true, false],
      question_type: 'boolean'
    )
    survey_question = Poptart::SurveyQuestion.new('question_id' => question.id)
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)

    survey = Poptart::Survey.create
    first_survey_question = survey.add_survey_question(survey_question)
    second_survey = Poptart::Survey.create
    second_survey_question = second_survey.add_survey_question(survey_question)

    first_survey_question.answer = true
    expect(first_survey_question.submit).to be

    second_survey_question.answer = false
    expect(second_survey_question.submit).to be

    survey_questions = Poptart::SurveyQuestion.find_all(question_id: question.id)
    expect(survey_questions.map(&:answer)).to match([true, false])
  end

  it "returns all answered survey questions for a question by key", :vcr do
    key = 'testingooptarts'
    question = Poptart::Question.create(
      'Do you like poptarts?',
      responses: [true, false],
      question_type: 'boolean',
      key: key
    )
    survey_question = Poptart::SurveyQuestion.new('question_id' => question.id)
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)

    survey = Poptart::Survey.create
    first_survey_question = survey.add_survey_question(survey_question)
    second_survey = Poptart::Survey.create
    second_survey_question = second_survey.add_survey_question(survey_question)

    first_survey_question.answer = true
    expect(first_survey_question.submit).to be

    second_survey_question.answer = false
    expect(second_survey_question.submit).to be

    survey_questions = Poptart::SurveyQuestion.find_all(key: key)
    expect(survey_questions.map(&:answer)).to match([true, false])
  end

  it "returns all answered survey questions for a survey", :vcr do
    key = 'testingooptarts'
    question = Poptart::Question.create(
      'Do you like poptarts?',
      responses: [true, false],
      question_type: 'boolean',
      key: key
    )
    survey_question = Poptart::SurveyQuestion.new('question_id' => question.id)
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)

    survey = Poptart::Survey.create
    first_survey_question = survey.add_survey_question(survey_question)
    second_survey_question = survey.add_survey_question(survey_question)

    first_survey_question.answer = true
    expect(first_survey_question.submit).to be

    second_survey_question.answer = false
    expect(second_survey_question.submit).to be

    survey_questions = Poptart::SurveyQuestion.find_all(survey_id: survey.id)
    expect(survey_questions.map(&:answer)).to match([true, false])
  end
end
