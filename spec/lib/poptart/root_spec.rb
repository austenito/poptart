require 'spec_helper'

describe Poptart::Root do
  context '#url' do
    it 'returns GET url by relation' do
      root = Poptart::Root.new('_links' => [{
          'rel' => 'survey_questions',
          'href' => 'http://example.com{?query*}',
          'method' => 'GET'
        },
        {
          'rel' => 'survey_questions',
          'href' => 'http://example.com/poptarts{?query*}',
          'method' => 'POST'
        },
      ])

      expect(root.url(relation: 'survey_questions')).to eq('http://example.com')
      expect(root.url(
        relation: 'survey_questions',
        method: 'POST')
      ).to eq('http://example.com/poptarts')
    end

    it 'returns GET url by relation' do
      root = Poptart::Root.new('_links' => [{
          'rel' => 'survey_questions',
          'href' => 'http://example.com{?query*}',
          'method' => 'GET'
      }])

      expect(root.url(relation: 'survey_questions')).to eq('http://example.com')
    end

    it 'returns url with query params' do
      root = Poptart::Root.new('_links' => [{
          'rel' => 'survey_questions',
          'href' => 'http://example.com/{survey_id}/{id}{?query*}',
          'method' => 'GET'
      }])

      expect(root.url(
        relation: 'survey_questions',
        survey_id: 'survey_id',
        id: 'id',
        query: { flavor: 'strawberry'}
      )).to eq('http://example.com/survey_id/id?flavor=strawberry')
    end
  end
end
