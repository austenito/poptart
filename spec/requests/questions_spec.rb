require 'spec_helper'

describe 'questions' do
  it 'creates a question', :vcr do
    question = Poptart::Question.create('Do you like poptarts?',
                                        question_type: 'boolean',
                                        responses: [true, false],
                                        key: 'poptarts')

    expect(question.id).to be
    expect(question.text).to eq('Do you like poptarts?')
    expect(question.responses).to eq([true, false])
    expect(question.key).to eq('poptarts')
  end
end
