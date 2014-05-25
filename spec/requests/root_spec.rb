require 'spec_helper'

describe Poptart::Root do
  it "returns survey links", :vcr do
    root = Poptart::Root.get_root
    root.links.self.href.should == 'http://localhost:3000/api'
  end
end
