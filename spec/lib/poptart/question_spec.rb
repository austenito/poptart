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

      root = double(:root, questions_url: 'questions_url')
      allow(Poptart::Question).to receive(:root).and_return(root)
      allow(Poptart::Question).to receive(:post).and_return(response)

      question = Poptart::Question.create('Do you like poptarts?',
                                          question_type: 'boolean',
                                          responses: ['Yes', 'No'],
                                          key: 'poptarts')

      expect(Poptart::Question).
        to have_received(:post).
        with('questions_url', 'question' => a_hash_including(response))
      expect(question.responses).to eq(['Yes', 'No'])
      expect(question.question_type).to eq('boolean')
      expect(question.text).to eq('Do you like poptarts?')
      expect(question.key).to eq('poptarts')
    end
  end
end
