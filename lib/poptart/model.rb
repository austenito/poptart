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

    def user_url(query: nil)
      template = Addressable::Template.new(links.users.href)
      template.expand(query: query).to_s
    end

    def surveys_url(id: nil, query: nil)
      template = Addressable::Template.new(links.surveys.href)
      template.expand(id: id, query: query).to_s
    end

    def questions_url(id: nil, query: nil)
      template = Addressable::Template.new(links.questions.href)
      template.expand(id: id, query: query).to_s
    end

    def survey_questions_url(survey_id:, id: nil, query: nil)
      template = Addressable::Template.new(links.survey_questions.href)
      template.expand(survey_id: survey_id, id: id, query: query).to_s
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
