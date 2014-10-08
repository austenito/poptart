require 'spec_helper'

describe 'creating quesitons' do
  it 'returns boolean question', :vcr do
    question = Poptart::BooleanQuestion.create("Do you like poptarts?", freeform: true, absolute_index: 10, parent_question_id: 42, key: 'poptarts')
    question.should be
    question.question_type.should == 'boolean'
    question.responses.should =~ [true, false]
    question.absolute_index.should == 10
    question.parent_question_id.should == 42
    question.freeform?.should be
    question.key.should == 'poptarts'
  end

  it 'returns multiple question', :vcr do
    responses = ['Yes', 'No']
    question = Poptart::MultipleResponseQuestion.create("Do you like poptarts?", responses: responses)
    question.should be
    question.question_type.should == 'multiple'
    question.responses.should =~  ['Yes', 'No']
  end

  it 'returns range question', :vcr do
    responses = [0, 10]
    question = Poptart::RangeQuestion.create("Do you like poptarts?", responses: responses)
    question.should be
    question.question_type.should == 'range'
    question.responses.should =~  [0, 10]
  end
end
