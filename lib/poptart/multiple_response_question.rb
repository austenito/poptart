module Poptart
  class MultipleResponseQuestion < Question
    extend Poptart::Request

    def self.question_type
      'multiple'
    end
  end
end
