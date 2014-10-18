module Poptart
  module Request
    def get(url, headers = {})
      connection.get do |req|
        req.url(url)
        req.headers['Content-Type'] = 'application/json'
        req.headers['API-TOKEN'] = Poptart.api_token if Poptart.api_token
        req.headers['USER-TOKEN'] = Poptart.user_token if Poptart.user_token
        req.headers['SERVICE-USER-ID'] = Poptart.service_user_id if Poptart.service_user_id
        req.headers.merge!(headers)
      end
    end

    def put(url, data, headers = {})
      connection.put do |req|
        req.url(url)
        req.body = data.to_json if data
        req.headers['Content-Type'] = 'application/json'
        req.headers['API-TOKEN'] = Poptart.api_token if Poptart.api_token
        req.headers['USER-TOKEN'] = Poptart.user_token if Poptart.user_token
        req.headers['SERVICE-USER-ID'] = Poptart.service_user_id if Poptart.service_user_id
        req.headers.merge!(headers)
      end
    end

    def post(url, data = {}, headers = {})
      connection.post do |req|
        req.url(url)
        req.body = data.to_json if data
        req.headers['Content-Type'] = 'application/json'
        req.headers['API-TOKEN'] = Poptart.api_token if Poptart.api_token
        req.headers['USER-TOKEN'] = Poptart.user_token if Poptart.user_token
        req.headers['SERVICE-USER-ID'] = Poptart.service_user_id if Poptart.service_user_id
        req.headers.merge!(headers)
      end
    end

    def connection
      return @connection if @connection
      @connection = Faraday.new(:url => Poptart.url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end
