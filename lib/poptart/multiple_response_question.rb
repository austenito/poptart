module Poptart
  class MultipleResponseQuestion < SurveyQuestion
    attr_accessor :responses

    def initialize(params)
      @responses = params['responses']
      super
    end

    def self.all
      root = Poptart::Root.get_root
      response = get("#{root.links.questions.href}?type=#{root.question_types['multiple_response']}")
      JSON.parse(response.body).map do |question|
        new(question)
      end
    end
  end
end
