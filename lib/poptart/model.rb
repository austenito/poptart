module Poptart
  class Model
    attr_accessor :id, :links

    def initialize(params)
      @id = params['id']
      @links = Hashie::Mash.new(params['_links'])
    end
  end
end
