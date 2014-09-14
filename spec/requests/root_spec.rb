require 'spec_helper'

describe Poptart::Root do
  it "builds urls", :vcr do
    root = Poptart::Root.root
    root.build_url('api/questions').should == 'http://localhost:3000/api/questions/'
    root.build_url('api/questions', id: 1).should == 'http://localhost:3000/api/questions/1'
    root.build_url('api/questions', id: 1, nested_resource: 'poptarts').should == 'http://localhost:3000/api/questions/1/poptarts'
    root.build_url('api/questions', query: {space: 'cat'}).should == 'http://localhost:3000/api/questions/?space=cat'
  end
end
