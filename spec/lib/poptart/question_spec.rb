require 'spec_helper'

describe Poptart::Question do
  context '.create' do
    it 'returns a created question' do
      response = {
        'text' => 'Do you like poptarts?',
        'question_type' => 'boolean',
        'responses' => ['Yes', 'No'],
        'key' => 'poptarts'
      }

      root = double(:root, url: 'questions_url')
      allow(Poptart::Question).to receive(:root).and_return(root)
      allow(Poptart::Question).to receive(:post).and_return(response)

      question = Poptart::Question.create('Do you like poptarts?',
                                          question_type: 'boolean',
                                          responses: ['Yes', 'No'],
                                          key: 'poptarts')

      expect(root).to have_received(:url).with(relation: 'questions', method: 'POST')
      expect(Poptart::Question).
        to have_received(:post).
        with('questions_url', 'question' => a_hash_including(response))
      expect(question.responses).to eq(['Yes', 'No'])
      expect(question.question_type).to eq('boolean')
      expect(question.text).to eq('Do you like poptarts?')
      expect(question.key).to eq('poptarts')
    end
  end

  context '.find' do
    it 'finds question' do
      response = { 'id' => 1 }

      root = double(:root, url: 'questions_url')
      allow(Poptart::Question).to receive(:root).and_return(root)
      allow(Poptart::Question).to receive(:get).and_return(response)

      question = Poptart::Question.find(1)

      expect(root).to have_received(:url).with(relation: 'questions', id: 1)
      expect(question.id).to eq(1)
    end
  end
end
