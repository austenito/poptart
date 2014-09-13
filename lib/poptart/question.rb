module Poptart
  class Question < Model
    extend Poptart::Request

    attr_accessor :responses, :freeform

    def initialize(response)
      super
      @responses = params['responses']
      @freeform = params['freeform']
    end

    def self.all(params = {})
      root = Poptart::Root.get_root
      response = get(root.questions_url)
      JSON.parse(response.body).map do |question|
        if params[:type]
          if question['question_type'] == params[:type]
            new(question)
          end
        else
          new(question)
        end
      end.compact
    end

    def freeform?
      @freeform
    end
  end
end
