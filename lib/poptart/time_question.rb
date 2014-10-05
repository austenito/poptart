module Poptart
  class TimeQuestion < Question
    extend Poptart::Request

    def self.question_type
      'time'
    end
  end
end
