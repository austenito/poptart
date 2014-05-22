module Poptart
  class User
    extend Poptart::Request
    attr_accessor :id, :external_user_id, :token

    def initialize(params)
      @id = params['id']
      @external_user_id = params['external_user_id']
      @token = params['token']
      @links = Hashie::Mash.new(params['_links'])
    end

    def self.create(user_id)
      root = Poptart::Root.get_root
      response = post(root.links.users.href, user: { user_id: user_id })
      Poptart::User.new(JSON.parse(response.body))
    end
  end
end
