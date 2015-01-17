module Poptart
  class SurveyQuestion < Model
    extend Poptart::Request
    include Poptart::Request

    attr_accessor :text, :answer, :question_type, :responses, :key, :question_id

    def initialize(response)
      super
      @text = params['text']
      @question_type = params['question_type']
      @responses = params['responses']
      @answer = params['answer']
      @created_at = params['created_at']
      @key = params['key']
      @question_id = params['question_id']

      if @answer == 't'
        @answer = true
      elsif @answer == 'f'
        @answer = false
      end
    end

    def boolean?
      question_type == "boolean"
    end

    def multiple?
      question_type == "multiple"
    end

    def range?
      question_type == "range"
    end

    def time?
      question_type == "time"
    end

    def created_at
      DateTime.parse(@created_at)
    end

    def submit
      response = put(links.put.href,
        {
          'id' => id,
          'survey_question' => {
            'answer' => answer
          }
        }
      )
      response.status == 204
    end
  end
end
