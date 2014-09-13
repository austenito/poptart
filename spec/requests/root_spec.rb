require 'spec_helper'

describe Poptart::Root do
  it "returns survey links", :vcr do
    root = Poptart::Root.get_root
    root.links.self.href.should == 'http://localhost:3000/api'
  end

  it "builds urls", :vcr, record: :all do
    root = Poptart::Root.get_root
    root.build_url('questions').should == 'http://localhost:3000/api/questions/'
    root.build_url('questions', id: 1).should == 'http://localhost:3000/api/questions/1'
    root.build_url('questions', id: 1, nested_resource: 'poptarts').should == 'http://localhost:3000/api/questions/1/poptarts'
    root.build_url('questions', query: {space: 'cat'}).should == 'http://localhost:3000/api/questions/?space=cat'
  end
end
