module Poptart
  class User < Model
    extend Poptart::Request
    include Poptart::Request
    attr_accessor :external_user_id, :token

    def initialize(response)
      super
      @external_user_id = params['external_user_id'].to_i
      @token = params['token']
    end

    def self.create(external_user_id)
      response = post(root.users_url, user: { external_user_id: external_user_id })
      Poptart::User.new(response)
    end

    def self.for_id(external_user_id)
      url = root.users_url(id: external_user_id)
      response = get(url)
      Poptart::User.new(response)
    end

    def create_survey
      response = post(root.surveys_url, survey: { user_id: id })
      Poptart::Survey.new(response)
    end

    def create_random_survey
      url = root.surveys_url(query: {random: true})
      response = post(url, survey: { user_id: id })
      Poptart::Survey.new(response)
    end

    def survey_for_id(id)
      url = root.surveys_url(id: id)
      response = get(url)
      Poptart::Survey.new(response)
    end

    def survey_for_url(url)
      response = get(url)
      Survey.new.extend(SurveyRepresenter).from_json(response.body)
    end

    def survey_questions_for_question_id(question_id)

    end

    private

    def self.root
      Poptart::Root.get_root
    end

    def root
      Poptart::Root.get_root
    end
  end
end
