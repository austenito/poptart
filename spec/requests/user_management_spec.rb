require 'spec_helper'

describe "User Management" do
  it "creates a user", :vcr do
    user = Poptart::User.create(142)
    user.id.should be
    user.external_user_id.should == 142
    user.token.should be
  end

  it "returns a user", :vcr do
    user = Poptart::User.create(143)
    other_user = Poptart::User.for_id(user.external_user_id)
    user.id.should == other_user.id
    user.external_user_id.should == other_user.external_user_id
  end
end
