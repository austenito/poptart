module Poptart
  class Question
    extend Poptart::Request

    attr_accessor :id

    def initialize(params)
      @id = params['id']
    end

    def self.all(params = {})
      root = Poptart::Root.get_root
      response = get(root.links.questions.href)
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
  end
end
