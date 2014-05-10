module Poptart
  class Root
    extend Poptart::Request

    attr_accessor :links

    def initialize(params)
      @links = Hashie::Mash.new(params['_links'])
    end

    def self.get_root
      response =  get("/")
      Poptart::Root.new(JSON.parse(response.body))
    end

    def create_survey
      Poptart::Survey.create
    end
  end
end
