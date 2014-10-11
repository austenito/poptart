module Poptart
  class SurveyQuestion < Model
    extend Poptart::Request
    include Poptart::Request

    attr_accessor :text, :answer, :type, :responses

    def initialize(response)
      super
      @text = params['text']
      @type = params['type']
      @freeform = params['freeform']
      @responses = params['responses']
      @answer = params['answer']
      @created_at = params['created_at']

      if @answer == 't'
        @answer = true
      elsif @answer == 'f'
        @answer = false
      end
    end

    def boolean?
      type == "boolean"
    end

    def multiple?
      type == "multiple"
    end

    def range?
      type == "range"
    end

    def time?
      type == "time"
    end

    def freeform?
      @freeform == true
    end

    def created_at
      DateTime.parse(@created_at)
    end

    def submit
      response = put(links.put.href, { id: id, survey_question: { answer: answer} })
      response.status == 204
    end
  end
end
