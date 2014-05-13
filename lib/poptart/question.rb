module Poptart
  class Question
    extend Poptart::Request

    def initialize(params)
      @id = params['id']
      @survey_id = params['survey_id']
    end

    # def self.all(type = nil)
      # root = Poptart::Root.get_root
      # response = get(root.links.questions.href)
      # new(JSON.parse(response.body))
    # end
  end
end
