module Poptart
  class User < Model
    extend Poptart::Request
    include Poptart::Request
    attr_accessor :service_user_id, :token

    def initialize(response)
      super
      @service_user_id = params['service_user_id']
      @token = params['token']
    end

    def self.create
      response = post(root.users_url)
      Poptart::User.new(response)
    end

    def self.for_id(service_user_id)
      url = root.users_url(id: service_user_id)
      response = get(url)
      Poptart::User.new(response)
    end

    def create_survey
      response = post(root.surveys_url, survey: { service_user_id: service_user_id })
      Poptart::Survey.new(response)
    end

    def create_random_survey
      url = root.surveys_url(query: {random: true})
      response = post(url, survey: { service_user_id: service_user_id })
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
  end
end
