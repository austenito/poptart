require 'spec_helper'

describe Poptart::Model do
  class Poptart::TestModel < Poptart::Model; end

  context '.new' do
    context 'response is a hash' do
      it 'sets id' do
        response = { 'id' => 1 }
        model = Poptart::TestModel.new(response)
        expect(model.id).to eq(1)
      end

      it 'sets links' do
        response = { '_links' => { 'self' => { 'href' => 'http://example.com' } } }
        model = Poptart::TestModel.new(response)
        expect(model.links).to eq('self' => { 'href' => 'http://example.com' })
      end
    end

    context 'response is http response object' do
      it 'sets id' do
        response = double(:response, status: 200, body: { 'id' => 1, status: 200 }.to_json)
        model = Poptart::TestModel.new(response)
        expect(model.id).to eq(1)
      end

      it 'sets links' do
        response = double(:response, status: 200, body: { '_links' => { 'self' => { 'href' => 'http://example.com' } } }.to_json)
        model = Poptart::TestModel.new(response)
        expect(model.links).to eq('self' => { 'href' => 'http://example.com' })
      end
    end

    context 'invalid response' do
      it 'raises unauthorized exception' do
        response = double(:response, status: 401)
        expect{
          Poptart::TestModel.new(response)
        }.to raise_exception('Unauthorized')
      end
    end
  end

  context '.root' do
    it 'returns Root' do
      root_response = double(:response)
      root = double(:root)
      allow(Poptart::Model).to receive(:get).with('/').and_return(root_response)
      allow(Poptart::Root).to receive(:new).with(root_response).and_return(root)

      returned_root = Poptart::TestModel.root

      expect(Poptart::Model).to have_received(:get).with('/')
      expect(Poptart::Root).to have_received(:new).with(root_response)
      expect(returned_root).to eq(root)
    end
  end

  context '#root' do
    it 'returns root' do
      root_response = double(:response)
      root = double(:root)
      allow(Poptart::Model).to receive(:get).with('/').and_return(root_response)
      allow(Poptart::Root).to receive(:new).with(root_response).and_return(root)

      model = Poptart::TestModel.new({})
      returned_root = model.root

      expect(Poptart::Model).to have_received(:get).with('/')
      expect(Poptart::Root).to have_received(:new).with(root_response)
      expect(returned_root).to eq(root)
    end
  end

  context '#user_url' do
    it 'returns user url' do
      model = Poptart::TestModel.new(
        '_links' => {
          'users' => {
            'href' => 'http://example.com/user{?query*}'
          }
        }
      )

      expect(model.user_url).to eq('http://example.com/user')
      expect(model.user_url(query: {
          flavor: 'strawberry'
        }
      )).to eq('http://example.com/user?flavor=strawberry')
    end
  end

  context '#surveys_url' do
    it 'returns survey url' do
      model = Poptart::TestModel.new(
        '_links' => {
          'surveys' => {
            'href' => 'http://example.com/surveys{/id}{?query*}'
          }
        }
      )

      expect(model.surveys_url).to eq('http://example.com/surveys')
      expect(model.surveys_url(id: 1, query: {
          flavor: 'strawberry'
        }
      )).to eq('http://example.com/surveys/1?flavor=strawberry')
    end
  end

  context '#questions_url' do
    it 'returns questions url' do
      model = Poptart::TestModel.new(
        '_links' => {
          'questions' => {
            'href' => 'http://example.com/questions{/id}{?query*}'
          }
        }
      )

      expect(model.questions_url).to eq('http://example.com/questions')
      expect(model.questions_url(id: 1, query: {
          flavor: 'strawberry'
        }
      )).to eq('http://example.com/questions/1?flavor=strawberry')
    end
  end

  context '#survey_questions_url' do
    it 'returns survey questions url' do
      model = Poptart::TestModel.new(
        '_links' => {
          'survey_questions' => {
            'href' => 'http://example.com/surveys/{survey_id}/survey_questions{/id}{?query*}'
          }
        }
      )

      expect(model.survey_questions_url(survey_id: 1)).to eq('http://example.com/surveys/1/survey_questions')
      expect(model.survey_questions_url(survey_id: 1, id: 16, query: {
          flavor: 'strawberry'
        }
      )).to eq('http://example.com/surveys/1/survey_questions/16?flavor=strawberry')
    end
  end
end

