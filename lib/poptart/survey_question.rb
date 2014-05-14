module Poptart
  class SurveyQuestion
    extend Poptart::Request

    attr_accessor :id, :text, :answer, :links, :type

    def initialize(params)
      @id = params['id']
      @text = params['text']
      @answer = params['answer']
      @type = params['type']
      @links = Hashie::Mash.new(params['_links'])
    end

    def submit
      response = Poptart::SurveyQuestion.put(links.submit.href, { id: id, survey_question: { answer: answer} })
      response.status == 204
    end
  end
end
