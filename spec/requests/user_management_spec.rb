require 'spec_helper'

describe "User Management" do
  it "creates a user", :vcr do
    user = Poptart::User.create
    user.service_user_id.should be
    user.token.should be
  end

  it "returns a user", :vcr do
    user = Poptart::User.create
    other_user = Poptart::User.for_id(user.service_user_id)
    user.service_user_id.should == other_user.service_user_id
  end
end
