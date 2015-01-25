require 'spec_helper'

describe 'questions' do
  it 'finds a question by id', :vcr do
    question = Poptart::Question.create('Do you like poptarts?',
                                        question_type: 'boolean',
                                        responses: [true, false],
                                        key: 'poptarts')

    question = Poptart::Question.find(question.id)

    expect(question.id).to eq(question.id)
    expect(question.text).to eq('Do you like poptarts?')
    expect(question.responses).to eq(['t', 'f'])
    expect(question.key).to eq('poptarts')
  end

  it 'finds a question by key', :vcr do
    question = Poptart::Question.create('Do you like poptarts?',
                                        question_type: 'boolean',
                                        responses: [true, false],
                                        key: 'poptarts')

    question = Poptart::Question.find('poptarts')

    expect(question.id).to eq(question.id)
    expect(question.text).to eq('Do you like poptarts?')
    expect(question.responses).to eq(['t', 'f'])
    expect(question.key).to eq('poptarts')
  end
end
