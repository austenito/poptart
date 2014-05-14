module Poptart
  class Root
    extend Poptart::Request

    attr_accessor :links, :question_types

    def initialize(params)
      @question_types = params['question_types']
      @links = Hashie::Mash.new(params['_links'])
    end

    def self.get_root
      response =  get("/")
      Poptart::Root.new(JSON.parse(response.body))
    end
  end
end
