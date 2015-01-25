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

  def self.service_user_id
    @service_user_id
  end

  def self.user_token
    @user_token
  end

  def self.authorize(service_user_id:, user_token:)
    @service_user_id = service_user_id
    @user_token = user_token
  end

  def self.reset_authorization
    @service_user_id = nil
    @user_token = nil
  end
end

require 'faraday'
require 'json'
require 'hashie'
require "addressable/template"

require_relative 'version'
require_relative 'poptart/request'
require_relative 'poptart/link'
require_relative 'poptart/model'
require_relative 'poptart/root'
require_relative 'poptart/survey'
require_relative 'poptart/survey_question'
require_relative 'poptart/question'
require_relative 'poptart/user'
