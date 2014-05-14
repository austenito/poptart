module Poptart
  class BooleanQuestion < SurveyQuestion
    extend Poptart::Request

    def initialize(params)
      super
      @answer = params['answer'] == 't'
    end

    def self.all
      root = Poptart::Root.get_root
      response = get("#{root.links.questions.href}?type=#{root.question_types['boolean']}")
      JSON.parse(response.body).map do |question|
        new(question)
      end
    end
  end
end
