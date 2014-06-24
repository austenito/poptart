module Poptart
  def self.api_token=(token)
    @token = token
  end

  def self.api_token
    @token
  end

  def self.url=(url)
    @url = url
  end

  def self.url
    @url || 'http://localhost:3000'
  end
end

require 'faraday'
require 'json'
require 'hashie'

require_relative 'version'
require_relative 'poptart/model'
require_relative 'poptart/request'
require_relative 'poptart/root'
require_relative 'poptart/survey'
require_relative 'poptart/survey_question'
require_relative 'poptart/question'
require_relative 'poptart/user'
