require 'spec_helper'

describe 'surveys' do
  it 'fetchs all surveys for a user', :vcr do
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    survey1 = user.create_survey
    survey2 = user.create_survey
    expect(user.surveys.map(&:id)).to eq([survey1.id, survey2.id])
  end
end
