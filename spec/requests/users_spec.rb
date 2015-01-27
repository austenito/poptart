require 'spec_helper'

describe Poptart::User do
  it "creates a user", :vcr do
    user = Poptart::User.create
    expect(user.service_user_id).to be
    expect(user.token).to be
  end
end
