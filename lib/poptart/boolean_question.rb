module Poptart
  class BooleanQuestion < SurveyQuestion
    extend Poptart::Request

    def initialize(params)
      super
    end

    def self.all
      root = Poptart::Root.get_root
      response = get(root.links.questions.href)
      JSON.parse(response.body).map do |question|
        new(question)
      end
    end

    # def self.create
      # response = Faraday.post(links.submit.href, { survey_id: survey_id, survey_question: { question_id: id, type: 'BooleanQuestion' })
      # new(JSON.parse(response.body))
    # end
  end
end
