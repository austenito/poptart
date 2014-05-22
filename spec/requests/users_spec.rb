require 'spec_helper'

describe Poptart::User do
  it "creates a user", :vcr do
    user = Poptart::User.create(42)
    user.id.should be
    user.external_user_id.should == 42
    user.token.should be
  end
end
