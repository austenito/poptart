module Poptart
  class Survey < Model
    include Poptart::Request
    attr_accessor :service_user_id, :survey_questions

    def initialize(response)
      super
      @service_user_id = params['service_user_id']
      @completed = params['completed']

      if params['survey_questions']
        @survey_questions = params['survey_questions'].map do |survey_question|
          SurveyQuestion.new(survey_question)
        end
      else
        @survey_questions = []
      end
    end

    def add_survey_question(survey_question)
      response = post(links.survey_questions.post.href, {
        'survey_question' => {
          'question_id' => survey_question.question_id,
          'responses' => survey_question.responses
        }
      })
      if response.status == 201
        survey_question = Poptart::SurveyQuestion.new(response)
        survey_questions << survey_question
        survey_question
      end
    end

    def survey_question_for_id(id)
      survey_questions.find do |survey_question|
        survey_question.id == id.to_i
      end
    end

    def completed?
      @completed
    end

    def self.create
      response = post(root.surveys_url)
      Poptart::Survey.new(response)
    end

    def self.all
      response = get(root.surveys_url)
      JSON.parse(response.body)['surveys'].map do |survey|
        Poptart::Survey.new(survey)
      end
    end

    def self.find(id)
      response = get(root.surveys_url(id: id))
      Poptart::Survey.new(response)
    end
  end
end
