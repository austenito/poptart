module Poptart
  class RangeQuestion < Question
    extend Poptart::Request

    def self.question_type
      'range'
    end
  end
end