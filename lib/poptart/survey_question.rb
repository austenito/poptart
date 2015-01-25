module Poptart
  class SurveyQuestion < Model
    extend Poptart::Request
    include Poptart::Request

    attr_accessor :text, :answer, :question_type, :responses, :key, :question_id

    def initialize(response)
      super
      @text = params['text']
      @question_type = params['question_type']
      @responses = params['responses']
      @answer = params['answer']
      @created_at = params['created_at']
      @key = params['key']
      @question_id = params['question_id']

      if @answer == 't'
        @answer = true
      elsif @answer == 'f'
        @answer = false
      end
    end

    def boolean?
      question_type == "boolean"
    end

    def multiple?
      question_type == "multiple"
    end

    def range?
      question_type == "range"
    end

    def time?
      question_type == "time"
    end

    def created_at
      DateTime.parse(@created_at)
    end

    def self.find_all(question_id: nil, key: nil, survey_id: nil)
      if question_id
        query = { question_id: question_id }
      elsif key
        query = { key: key }
      elsif survey_id
        query = { survey_id: survey_id }
      end

      url = root.url(relation: 'survey-questions-by-query', query: query)
      response = get(url)
      JSON.parse(response.body)["survey_questions"].map do |response_body|
        Poptart::SurveyQuestion.new(response_body)
      end
    end

    def submit
      url = url(method: 'PUT', relation: 'self')
      response = put(url,
        {
          'id' => id,
          'survey_question' => {
            'answer' => answer
          }
        }
      )
      response.status == 204
    end
  end
end
