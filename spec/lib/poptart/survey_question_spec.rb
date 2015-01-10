require 'spec_helper'

describe Poptart::SurveyQuestion do
  context 'attributes' do
    it 'returns question id' do
      survey_question = Poptart::SurveyQuestion.new('question_id' => 1)
      expect(survey_question.question_id).to eq(1)
    end

    it 'returns text' do
      survey_question = Poptart::SurveyQuestion.new('text' => 'poptarts')
      expect(survey_question.text).to eq('poptarts')
    end

    it 'returns type' do
      survey_question = Poptart::SurveyQuestion.new('type' => 'type')
      expect(survey_question.type).to eq('type')
    end

    it 'returns responses' do
      survey_question = Poptart::SurveyQuestion.new('responses' => ['Yes', 'No'])
      expect(survey_question.responses).to eq(['Yes', 'No'])
    end

    it 'returns answer' do
      survey_question = Poptart::SurveyQuestion.new('answer' => 'Toasted')
      expect(survey_question.answer).to eq('Toasted')
    end

    it 'returns created at' do
      survey_question = Poptart::SurveyQuestion.new('created_at' => '2014-01-01')
      expect(survey_question.created_at).to eq(Date.parse('2014-01-01'))
    end

    it 'returns key' do
      survey_question = Poptart::SurveyQuestion.new('key' => 'poptarts_key')
      expect(survey_question.key).to eq('poptarts_key')
    end
  end

  context '#boolean?' do
    it 'returns true' do
      survey_question = Poptart::SurveyQuestion.new('type' => 'boolean')
      expect(survey_question.boolean?).to eq(true)
    end
  end

  context '#multiple?' do
    it 'returns true' do
      survey_question = Poptart::SurveyQuestion.new('type' => 'multiple')
      expect(survey_question.multiple?).to eq(true)
    end
  end

  context '#range?' do
    it 'returns true' do
      survey_question = Poptart::SurveyQuestion.new('type' => 'range')
      expect(survey_question.range?).to eq(true)
    end
  end

  context '#time?' do
    it 'returns true' do
      survey_question = Poptart::SurveyQuestion.new('type' => 'time')
      expect(survey_question.time?).to eq(true)
    end
  end

  context '#answer' do
    it 'returns true if answer is "t"' do
      survey_question = Poptart::SurveyQuestion.new('answer' => 't')
      expect(survey_question.answer).to eq(true)
    end

    it 'returns false if answer is "f"' do
      survey_question = Poptart::SurveyQuestion.new('answer' => 'f')
      expect(survey_question.answer).to eq(false)
    end
  end
end
