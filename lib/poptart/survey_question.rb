module Poptart
  class SurveyQuestion
    extend Poptart::Request

    attr_accessor :id, :text, :answer, :links, :type, :responses

    def initialize(params)
      @id = params['id']
      @text = params['text']
      @answer = params['answer']
      @type = params['type']
      @responses = params['responses']
      @links = Hashie::Mash.new(params['_links'])
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

    def submit
      response = Poptart::SurveyQuestion.put(links.submit.href, { id: id, survey_question: { answer: answer} })
      response.status == 204
    end
  end
end
