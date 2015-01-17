require 'spec_helper'

describe Poptart::Survey, :vcr do
  it 'creates an empty survey' do
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    survey = Poptart::Survey.create
    expect(Poptart::Survey.all.map(&:id).include?(survey.id)).to eq(true)
  end

  it 'returns a survey by id' do
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    survey = Poptart::Survey.create
    returned_survey = Poptart::Survey.find(survey.id)
    expect(returned_survey.id).to eq(survey.id)
  end

  it 'adds a question to a survey' do
    question = Poptart::Question.create('Do you like poptarts?',
                                        question_type: 'boolean',
                                        responses: [true, false])

    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    survey = Poptart::Survey.create
    expect(survey.survey_questions.count).to eq(0)

    survey_question = Poptart::SurveyQuestion.new('question_id' => question.id)

    survey_question = survey.add_survey_question(survey_question)
    expect(survey_question).to be
    expect(survey_question.id).to be

    survey = Poptart::Survey.find(survey.id)
    expect(survey.survey_questions.count).to eq(1)
    expect(survey.survey_questions.first.id).to eq(survey_question.id)
    expect(survey.survey_questions.first.responses).to eq(['t', 'f'])
  end
end
