module Poptart
  class User < Model
    extend Poptart::Request
    include Poptart::Request
    attr_accessor :service_user_id, :token

    def initialize(response)
      super
      @service_user_id = params['service_user_id']
      @token = params['token']
    end

    def self.create
      url = root.url(relation: 'users', method: 'POST')
      response = post(url)
      Poptart::User.new(response)
    end
  end
end
