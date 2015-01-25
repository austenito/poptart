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
        response = {
          '_links' => [
            { 'rel' => 'self',
              'href' => 'http://example.com'
            }
          ]
        }
        model = Poptart::TestModel.new(response)
        expect(model.links.count).to eq(1)
        link = model.links.first
        expect(link.rel).to eq('self')
        expect(link.href).to eq('http://example.com')
      end
    end

    context 'response is http response object' do
      it 'sets id' do
        response = double(:response, status: 200, body: { 'id' => 1, status: 200 }.to_json)
        model = Poptart::TestModel.new(response)
        expect(model.id).to eq(1)
      end

      it 'sets links' do
        response = double(:response, status: 200, body: {
          '_links' => [
            { 'rel' => 'self',
              'href' => 'http://example.com'
            }
          ]
        }.to_json)

        model = Poptart::TestModel.new(response)
        expect(model.links.count).to eq(1)
        link = model.links.first
        expect(link.rel).to eq('self')
        expect(link.href).to eq('http://example.com')
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
end

