module Poptart
  module Request
    # get survey with one type of question
    #   for each question, depending on what it is build it
    #     answer the question
    #     loop
    #

    def get(url)
      connection.get do |req|
        req.url(url)
        req.headers['Content-Type'] = 'application/json'
      end
    end

    def put(url, data = {})
      connection.put do |req|
        req.url(url)
        req.headers['Content-Type'] = 'application/json'
      end
    end

    def post(url, data = {})
      connection.post do |req|
        req.url(url)
        req.headers['Content-Type'] = 'application/json'
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
