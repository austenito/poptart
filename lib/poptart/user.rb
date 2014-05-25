module Poptart
  class User < Model
    extend Poptart::Request
    include Poptart::Request
    attr_accessor :external_user_id, :token

    def initialize(response)
      super
      @external_user_id = params['external_user_id']
      @token = params['token']
    end

    def self.create(external_user_id)
      root = Poptart::Root.get_root
      response = post(root.links.users.href, user: { external_user_id: external_user_id })
      Poptart::User.new(response)
    end

    def self.for_id(external_user_id)
      root = Poptart::Root.get_root
      response = get("#{root.links.users.href}/#{external_user_id}")
      Poptart::User.new(response)
    end

    def create_survey
      root = Poptart::Root.get_root
      response = post(root.links.surveys.href, survey: { user_id: id })
      Poptart::Survey.new(response)
    end

    def create_random_survey
      response = post("/api/surveys?random=true", survey: { user_id: id })
      Poptart::Survey.new(response)
    end

    def survey_for_id(id)
      response = get("/api/surveys/#{id}")
      Poptart::Survey.new(response)
    end

    def survey_for_url(url)
      response = get(url)
      Survey.new.extend(SurveyRepresenter).from_json(response.body)
    end
  end
end
