module Poptart
  class BooleanQuestion < Question
    extend Poptart::Request

    def self.create(text, freeform: false, absolute_index: nil, parent_question_id: nil, key: nil)
      super(text, responses: [true, false], freeform: freeform,
            absolute_index: absolute_index, parent_question_id: parent_question_id, key: key)
    end

    def self.question_type
      'boolean'
    end
  end
end
