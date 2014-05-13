module Poptart
  class Survey
    extend Poptart::Request
    attr_accessor :id
    attr_accessor :survey_questions

    def initialize(params)
      @id = params['id']
      @links = Hashie::Mash.new(params['_links'])

      @survey_questions = params['survey_questions'].map do |survey_question|
        SurveyQuestion.new(survey_question)
      end.sort_by { |survey_question| survey_question.id }
    end

    def self.create
      response = post("/api/surveys")
      Poptart::Survey.new(JSON.parse(response.body))
    end

    def self.create_random
      response = post("/api/surveys?random=true")
      Poptart::Survey.new(JSON.parse(response.body))
    end

    def self.for_id(id)
      response = get("/api/surveys/#{id}")
      Poptart::Survey.new(JSON.parse(response.body))
    end

    def self.for_url(url)
      response = Faraday.get(url)
      Survey.new.extend(SurveyRepresenter).from_json(response.body)
    end

    def next_question
      if links['next']
        SurveyQuestion.for_url(links['next']['href'])
      end
    end
  end
end
