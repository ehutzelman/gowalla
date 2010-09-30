require 'faraday'
require 'faraday_middleware'
require 'oauth2'
require 'active_support/inflector'

require 'gowalla/client'

module Gowalla

  class << self
    attr_accessor :api_key
    attr_accessor :username
    attr_accessor :password
    attr_accessor :api_secret
    attr_accessor :test_mode

    # config/initializers/gowalla.rb (for instance)
    #
    # Gowalla.configure do |config|
    #   config.api_key = 'api_key'
    #   config.username = 'username'
    #   config.password = 'password'
    # end
    #
    # elsewhere
    #
    # client = Gowalla::Client.new
    def configure
      yield self
      true
    end

    def test_mode?
      !!self.test_mode
    end
  end

end
