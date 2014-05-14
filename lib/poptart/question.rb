module Poptart
  class Question
    extend Poptart::Request

    def initialize(params)
      @id = params['id']
      @survey_id = params['survey_id']
    end
  end
end
