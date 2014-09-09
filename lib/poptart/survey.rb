module Poptart
  class Survey < Model
    include Poptart::Request
    attr_accessor :user_id, :survey_questions

    def initialize(response)
      super
      @user_id = params['user_id']
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
      response = post("#{links.self.href}/survey_questions",
                                      { survey_question: { question_id: question.id } } )
      response.status == 201
    end

    def survey_question_for_id(id)
      survey_questions.find do |survey_question|
        survey_question.id == id.to_i
      end
    end

    def next_question
      if links['next']
        SurveyQuestion.for_url(links['next']['href'])
      end
    end

    def completed?
      @completed
    end
  end
end
