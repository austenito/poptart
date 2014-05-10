module Poptart
  class MultipleResponseQuestion < SurveyQuestion
    attr_accessor :responses

    def initialize(params)
      @responses = params['responses']
      super
    end
  end
end
