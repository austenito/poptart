module Poptart
  class BooleanQuestion < SurveyQuestion
    extend Poptart::Request

    def initialize(params)
      super
      @answer = params['answer'] == 't'
    end

    def self.all
      root = Poptart::Root.get_root
      response = get(root.links.questions.href)
      JSON.parse(response.body).map do |question|
        if question['questionable_type'] == "BooleanQuestion"
          new(question)
        end
      end.compact
    end
  end
end
