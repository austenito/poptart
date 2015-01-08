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
      response = post(root.user_url)
      Poptart::User.new(response)
    end

    def self.get_user
      response = get(root.user_url)
      Poptart::User.new(response)
    end

    # def survey_for_id(id)
      # url = root.surveys_url(id: id)
      # response = get(url)
      # Poptart::Survey.new(response)
    # end

    def survey_questions_for_question_id(question_id)
      url = root.survey_questions_url(question_id: question_id)
      response = get(url)
      JSON.parse(response.body)["survey_questions"].map { |response_body| Poptart::SurveyQuestion.new(response_body) }
    end

    def survey_questions_for_key(key)
      survey_questions_for_question_id(key)
    end

    def surveys
      response = get(root.surveys_url)
      JSON.parse(response.body)["surveys"].map { |response_body| Poptart::Survey.new(response_body) }
    end

    private
  end
end
