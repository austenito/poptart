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

  context '.all' do
    it 'returns all surveys' do
      root = double(:root, surveys_url: 'surveys_url')
      response = double(:response, body: { surveys: [{ id: 1 }] }.to_json)
      allow(Poptart::Survey).to receive(:root).and_return(root)
      allow(Poptart::Survey).to receive(:get).and_return(response)

      surveys = Poptart::Survey.all

      expect(Poptart::Survey).to have_received(:get).with('surveys_url')
      expect(surveys.count).to eq(1)
      expect(surveys.first).to be
      expect(surveys.first.id).to eq(1)
    end
  end

  context '.create' do
    it 'creates an empty survey' do
      root = double(:root, surveys_url: 'surveys_url')
      response = double(:response, status: 201, body: { id: 1 }.to_json)
      allow(Poptart::Survey).to receive(:root).and_return(root)
      allow(Poptart::Survey).to receive(:post).and_return(response)

      survey = Poptart::Survey.create

      expect(Poptart::Survey).to have_received(:post).with('surveys_url')
      expect(survey.id).to be
    end
  end

  context '.find' do
    it 'returns a survey' do
      root = double(:root, surveys_url: 'surveys_url/1')
      response = double(:response, status: 200, body: { id: 1 }.to_json)
      allow(Poptart::Survey).to receive(:root).and_return(root)
      allow(Poptart::Survey).to receive(:get).and_return(response)

      survey = Poptart::Survey.find(1)

      expect(root).to have_received(:surveys_url).with(id: 1)
      expect(Poptart::Survey).to have_received(:get).with('surveys_url/1')
      expect(survey.id).to eq(1)
    end
  end

  context '#add_question' do
    it 'adds a survey question to a survey' do
      survey = Poptart::Survey.new({})
      allow(survey).to receive_message_chain(
        :links,
        :survey_questions,
        :post,
        :href
      ).and_return('survey_questions_url')

      response = double(:response, status: 201, body: { 'id' => 1 }.to_json)
      allow(survey).to receive(:post).and_return(response)

      survey_question = Poptart::SurveyQuestion.new(
        'question_id' => 1,
        'responses' => [true, false]
      )
      survey_question = survey.add_survey_question(survey_question)

      body = {
        'survey_question' => {
          'question_id' => 1,
          'responses' => [true, false]
        }
      }
      expect(survey).to have_received(:post).with('survey_questions_url', body)
      expect(survey_question.id).to eq(1)
      expect(survey.survey_questions.include?(survey_question)).to eq(true)
    end
  end
end
