module Poptart
  class Root < Model
    extend Poptart::Request
    attr_accessor :links

    def self.get_root
      response =  get("/")
      Poptart::Root.new(response)
    end
  end
end
