module Poptart
  class Question < Model
    extend Poptart::Request

    attr_accessor :responses, :question_type, :key, :text

    def initialize(response)
      super
      @responses = params['responses']
      @question_type = params['question_type']
      @text = params['text']
      @key = params['key']
    end

    def self.create(text,
                    responses: [],
                    question_type: nil,
                    key: nil)

      question_data = {
        'question_type' => question_type,
        'responses' => responses,
        'text' => text,
        'key' => key
      }
      response = post(root.questions_url, 'question' => question_data)
      new(response)
    end

    def self.all(params = {})
      response = get(root.questions_url)
      JSON.parse(response.body).map do |question|
        if params[:type]
          if question['question_type'] == params[:type]
            new(question)
          end
        else
          new(question)
        end
      end.compact
    end
  end
end
