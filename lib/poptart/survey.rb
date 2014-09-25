module Poptart
  class Survey < Model
    include Poptart::Request
    attr_accessor :service_user_id, :survey_questions

    def initialize(response)
      super
      @service_user_id = params['service_user_id']
      @completed = params['completed']

      @survey_questions = params['survey_questions'].map do |survey_question|
        if survey_question['type'] == 'BooleanQuestion'
          BooleanQuestion.new(survey_question)
        else
          SurveyQuestion.new(survey_question)
        end
      end.sort_by { |survey_question| survey_question.id }
    end

    def add_question(question)
      url = build_url(links.survey_questions.post.href)
      response = post(url, { survey_question: { question_id: question.id } } )
      if response.status == 201
        Poptart::SurveyQuestion.new(response).tap { |survey_question| survey_questions << survey_question }
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
  end
end
