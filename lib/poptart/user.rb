module Poptart
  class User
    extend Poptart::Request
    attr_accessor :id, :external_user_id, :token

    def initialize(params)
      @id = params['id']
      @external_user_id = params['external_user_id']
      @token = params['token']
      @links = Hashie::Mash.new(params['_links'])
    end

    def self.create(external_user_id)
      root = Poptart::Root.get_root
      response = Poptart::User.post(root.links.users.href, user: { external_user_id: external_user_id })
      Poptart::User.new(JSON.parse(response.body))
    end

    def create_survey
      root = Poptart::Root.get_root
      response = Poptart::User.post(root.links.surveys.href, survey: { user_id: id })
      Poptart::Survey.new(JSON.parse(response.body))
    end

    def create_random_survey
      response = Poptart::User.post("/api/surveys?random=true", survey: { user_id: id })
      Poptart::Survey.new(JSON.parse(response.body))
    end

    def survey_for_id(id)
      response = Poptart::User.get("/api/surveys/#{id}")
      Poptart::Survey.new(JSON.parse(response.body))
    end

    def survey_for_url(url)
      response = Faraday.get(url)
      Survey.new.extend(SurveyRepresenter).from_json(response.body)
    end
  end
end
