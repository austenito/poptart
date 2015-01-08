require 'spec_helper'

describe Poptart::Survey do
  it 'creates an empty survey', :vcr, record: :all do
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    survey = Poptart::Survey.create
    expect(Poptart::Survey.all.map(&:id).include?(survey.id)).to eq(true)
  end

  xit 'returns a survey by id', :vcr, record: :all do
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    survey = Poptart::Survey.create
    returned_survey = Poptart::Survey.for_id(survey.id)
    expect(returned_survey.id).to eq(survey.id)
  end
  # it 'fetchs all surveys for a user', :vcr do
    # user = Poptart::User.create
    # Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    # survey1 = user.create_survey
    # survey2 = user.create_survey
    # expect(user.surveys.map(&:id)).to eq([survey1.id, survey2.id])
  # end
  #
  xit 'adds a question to a survey', :vcr, record: :all do
    # need to test creating the other questions first
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    survey = Survey.create

    survey.add_question(survey_question)

  end
end
