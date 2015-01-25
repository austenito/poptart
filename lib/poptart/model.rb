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

      @links = []
      if @params['_links']
        @params['_links'].each do |link|
          @links << Link.new(href: link['href'], rel: link['rel'], method: link['method'])
        end
      end
    end

    def self.root
      return @root if @root
      response =  get("/")
      @root = Poptart::Root.new(response)
    end

    def root
      Poptart::Model.root
    end

    def url(relation: , method: 'GET', query: nil, survey_id: nil, id: nil)
      link = find_link(relation, method)
      template = Addressable::Template.new(link.href)
      template.expand(survey_id: survey_id, id: id, query: query).to_s
    end

    private

    def find_link(relation, method)
      links.find { |link| link.rel == relation && link.method == method }
    end
  end
end
