module Poptart
  class Survey
    extend Poptart::Request
    attr_accessor :id, :survey_questions, :links

    def initialize(params)
      @id = params['id']
      @links = Hashie::Mash.new(params['_links'])

      @survey_questions = params['survey_questions'].map do |survey_question|
        if survey_question['type'] == 'BooleanQuestion'
          BooleanQuestion.new(survey_question)
        else
          SurveyQuestion.new(survey_question)
        end
      end.sort_by { |survey_question| survey_question.id }
    end

    def self.create
      root = Poptart::Root.get_root
      response = post(root.links.surveys.href)
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

    def add_question(question)
      response = Poptart::Survey.post("#{links.self.href}/survey_questions",
                                      { survey_question: { question_id: question.id } } )
      response.status == 201
    end

    def survey_question_for_id(id)
      survey_questions.find do |survey_question|
        survey_question.id == id
      end
    end

    def next_question
      if links['next']
        SurveyQuestion.for_url(links['next']['href'])
      end
    end
  end
end
