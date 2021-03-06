require 'spec_helper'

describe Poptart::User do
  context '.new' do
    it 'sets service user id' do
      user = Poptart::User.new('service_user_id' => 1)
      expect(user.service_user_id).to eq(1)
    end

    it 'sets token' do
      user = Poptart::User.new('token' => 'poptart')
      expect(user.token).to eq('poptart')
    end
  end

  context '.create' do
    it 'creates a user' do
      root = double(:root, url: 'user_url')
      user_response = { 'id' => 1 }
      allow(Poptart::User).to receive(:root).and_return(root)
      allow(Poptart::User).to receive(:post).and_return(user_response)

      user = Poptart::User.create

      expect(root).to have_received(:url).with(relation: 'users', method: 'POST')
      expect(Poptart::User).to have_received(:post).with('user_url')
      expect(user.id).to eq(1)
    end
  end
end
