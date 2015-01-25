require 'spec_helper'

describe Poptart::User do
  it "creates a user", :vcr do
    user = Poptart::User.create
    expect(user.service_user_id).to be
    expect(user.token).to be
  end

  it "returns a user", :vcr do
    user = Poptart::User.create
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)
    other_user = Poptart::User.get_user
    expect(user.service_user_id).to eq(other_user.service_user_id)
  end
end
