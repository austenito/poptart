module Poptart
  class Model
    attr_accessor :id, :links, :params

    def initialize(response)
      if response.respond_to?(:has_key?)
        @params = response
      else
        raise "Unauthorized"if response.status == 401
        @params = JSON.parse(response.body)
      end

      @id = @params['id']
      @links = Hashie::Mash.new(@params['_links'])
    end
  end
end
