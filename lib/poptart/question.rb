module Poptart
  class Question < Model
    extend Poptart::Request

    attr_accessor :responses, :freeform, :question_type, :absolute_index, :parent_question_id, :key

    def initialize(response)
      super
      @responses = params['responses']
      @freeform = params['freeform']
      @question_type = params['question_type']
      @absolute_index = params['absolute_index']
      @parent_question_id = params['parent_question_id']
      @key = params['key']
    end

    def self.create(text, responses: [], freeform: false, absolute_index: nil, parent_question_id: nil, key: nil)
      response = post(root.questions_url, question: { question_type: question_type,
                                                      responses: responses,
                                                      text: text,
                                                      freeform: freeform,
                                                      absolute_index: absolute_index,
                                                      parent_question_id: parent_question_id,
                                                      key: key})
      new(response)
    end

    def self.all(params = {})
      response = get(root.questions_url)
      JSON.parse(response.body).map do |question|
        if params[:type]
          if question['question_type'] == params[:type]
            new(question)
          end
        else
          new(question)
        end
      end.compact
    end

    def freeform?
      @freeform
    end
  end
end
