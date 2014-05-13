module Poptart
  class SurveyQuestion
    include Poptart::Request

    attr_accessor :id, :text, :answer, :links

    def initialize(params)
      @id = params['id']
      @text = params['text']
      @answer = params['answer']
      @links = Hashie::Mash.new(params['_links'])
    end

    def submit
      response = Faraday.put(links.submit.href, { id: id, survey_question: { answer: answer} })
      response.status == 204
    end
  end
end
