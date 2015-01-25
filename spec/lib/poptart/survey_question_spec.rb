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
      survey_question = Poptart::SurveyQuestion.new('question_type' => 'boolean')
      expect(survey_question.boolean?).to eq(true)
    end
  end

  context '#multiple?' do
    it 'returns true' do
      survey_question = Poptart::SurveyQuestion.new('question_type' => 'multiple')
      expect(survey_question.multiple?).to eq(true)
    end
  end

  context '#range?' do
    it 'returns true' do
      survey_question = Poptart::SurveyQuestion.new('question_type' => 'range')
      expect(survey_question.range?).to eq(true)
    end
  end

  context '#time?' do
    it 'returns true' do
      survey_question = Poptart::SurveyQuestion.new('question_type' => 'time')
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

  context '#submit' do
    it 'submits a survey question' do
      survey_question = Poptart::SurveyQuestion.new('id' => 1, 'answer' => 'poptarts')
      allow(survey_question).to receive(:url).and_return('survey_questions_url')
      response = double(:response, status: 204, body: { id: 1 }.to_json)
      allow(survey_question).to receive(:put).and_return(response)

      submit_result = survey_question.submit

      expect(survey_question).to have_received(:url).with(
        relation: 'self',
        method: 'PUT'
      )
      expect(survey_question).to have_received(:put).with(
        'survey_questions_url',
        {
          'id' => 1,
          'survey_question' => {
            'answer' => 'poptarts'
          }
        }
      )
      expect(submit_result).to eq(true)
    end
  end

  context '.find_all' do
    it 'finds all survey questions by question id' do
      body = {
        'survey_questions' => [{
          'text' => 'Do you like poptarts?'
        }]
      }
      response = double(:response, body: body.to_json)

      root = double(:root, url: 'survey_questions_url')
      allow(Poptart::SurveyQuestion).to receive(:root).and_return(root)
      allow(Poptart::SurveyQuestion).to receive(:get).and_return(response)

      survey_questions = Poptart::SurveyQuestion.find_all(question_id: 1)

      expect(root).to have_received(:url).with(relation: 'survey-questions-by-query', query: { question_id: 1})
      expect(Poptart::SurveyQuestion).to have_received(:get).with('survey_questions_url')
      expect(survey_questions.count).to eq(1)
      survey_question = survey_questions.first
      expect(survey_question.text).to eq('Do you like poptarts?')
    end

    it 'finds all survey questions by question key' do
      body = {
        'survey_questions' => [{
          'text' => 'Do you like poptarts?'
        }]
      }
      response = double(:response, body: body.to_json)

      root = double(:root, url: 'survey_questions_url')
      allow(Poptart::SurveyQuestion).to receive(:root).and_return(root)
      allow(Poptart::SurveyQuestion).to receive(:get).and_return(response)

      survey_questions = Poptart::SurveyQuestion.find_all(key: 'poptarts')

      expect(root).to have_received(:url).with(relation: 'survey-questions-by-query', query: { key: 'poptarts' })
      expect(Poptart::SurveyQuestion).to have_received(:get).with('survey_questions_url')
      expect(survey_questions.count).to eq(1)
      survey_question = survey_questions.first
      expect(survey_question.text).to eq('Do you like poptarts?')
    end

    it 'finds all survey questions by survey' do
      body = {
        'survey_questions' => [{
          'text' => 'Do you like poptarts?'
        }]
      }
      response = double(:response, body: body.to_json)

      root = double(:root, url: 'survey_questions_url')
      allow(Poptart::SurveyQuestion).to receive(:root).and_return(root)
      allow(Poptart::SurveyQuestion).to receive(:get).and_return(response)

      survey_questions = Poptart::SurveyQuestion.find_all(survey_id: 1)

      expect(root).to have_received(:url).with(relation: 'survey-questions-by-query', query: { survey_id: 1 })
      expect(Poptart::SurveyQuestion).to have_received(:get).with('survey_questions_url')
      expect(survey_questions.count).to eq(1)
      survey_question = survey_questions.first
      expect(survey_question.text).to eq('Do you like poptarts?')
    end
  end
end
