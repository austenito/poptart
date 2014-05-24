module Poptart
  class Root < Model
    extend Poptart::Request
    attr_accessor :links

    def self.get_root
      response =  get("/")
      Poptart::Root.new(JSON.parse(response.body))
    end
  end
end
