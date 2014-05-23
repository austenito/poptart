module Poptart
  module Request
    def get(url, headers = {})
      connection.get do |req|
        req.url(url)
        req.headers['Content-Type'] = 'application/json'
        req.headers.merge!(headers)
      end
    end

    def put(url, data, headers = {})
      connection.put do |req|
        req.url(url)
        req.body = data.to_json if data
        req.headers['Content-Type'] = 'application/json'
        req.headers.merge!(headers)
      end
    end

    def post(url, data, headers = {})
      connection.post do |req|
        req.url(url)
        req.body = data.to_json if data
        req.headers['Content-Type'] = 'application/json'
        req.headers.merge!(headers)
      end
    end

    def connection
      return @connection if @connection

      # if Rails.env.production?
        # url = ""
      # else
        url = "http://localhost:3000"
      # end

      @connection = Faraday.new(:url => url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end
