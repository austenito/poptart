module Poptart
  class Model
    extend Poptart::Request

    attr_accessor :id, :links, :params, :root

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

    def self.root
      return @root if @root
      response =  get("/")
      @root = Poptart::Root.new(response)
    end

    def root
      Poptart::Model.root
    end

    def build_url(resource, id: nil, nested_resource: nil, query: nil)
      template_string = "#{scheme}://#{host}/{+resource}/{id}"
      if nested_resource
        template_string += "/{nested_resource}"
      end
      template_string += "{?query*}"
      template = Addressable::Template.new(template_string)
      template.expand(resource: resource, id: id, nested_resource: nested_resource, query: query).to_s
    end

    def users_url(id: nil, query: nil)
      build_url(links.users.href, id: id, query: query)
    end

    def surveys_url(id: nil, query: nil)
      build_url(links.surveys.href, id: id, query: query)
    end

    def questions_url(id: nil, query: nil)
      build_url(links.questions.href, id: id, query: query)
    end

    private

    def root_uri
      @root_uri = URI.parse(root.links.self.href)
    end

    def scheme
      root_uri.scheme
    end

    def host
      root_uri.port ? "#{root_uri.host}:#{root_uri.port}" : root_uri.host
    end
  end
end
