require 'spec_helper'

describe Poptart::Survey do
  context '#completed?' do
    it 'returns true' do
      survey = Poptart::Survey.new('completed' => true, 'survey_questions' => [])
      expect(survey.completed?).to be
    end
  end

  context '#service_user_id' do
    it 'returns the service user id' do
      survey = Poptart::Survey.new('service_user_id' => 1, 'survey_questions' => [])
      expect(survey.service_user_id).to eq(1)
    end
  end

  context '#survey_questions' do
    it 'returns survey questions' do
      survey_question_response = double(:response)
      survey_question = double(:survey_question)
      allow(Poptart::SurveyQuestion).to receive(:new).
        with(survey_question_response).and_return(survey_question)

      survey = Poptart::Survey.new('survey_questions' => [survey_question_response])
      expect(survey.survey_questions.count).to eq(1)
      expect(survey.survey_questions).to include(survey_question)
    end
  end
end
