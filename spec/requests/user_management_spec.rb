require 'spec_helper'

describe "User Management", :vcr do
  it "creates a user" do
    user = Poptart::User.create(42)
    user.id.should be
    user.external_user_id.should == 42
    user.token.should be
  end

  it "returns a user" do
    user = Poptart::User.create(43)
    other_user = Poptart::User.for_id(user.external_user_id)
    user.id.should == other_user.id
    user.external_user_id.should == other_user.external_user_id
  end
end
