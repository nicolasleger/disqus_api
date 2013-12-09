require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/try'
require 'yaml'
require 'json'
require 'faraday'
require 'faraday_middleware'

require 'disqus_api/api'
require 'disqus_api/namespace'
require 'disqus_api/request'
require 'disqus_api/response'

module DisqusApi

  def self.adapter
    @adapter || Faraday.default_adapter
  end

  def self.adapter=(value)
    @adapter = value
  end

  # @return [ActiveSupport::HashWithIndifferentAccess]
  def self.config
    @config || raise("No configuration specified for Disqus")
  end

  # @param [Hash] config
  # @option config [String] :api_secret
  # @option config [String] :api_key
  # @option config [String] :access_token
  def self.config=(config)
    @config = ActiveSupport::HashWithIndifferentAccess.new(config)
  end

  # @param [String] version
  # @return [Api]
  def self.init(version)
    Api.new(version, YAML.load_file(File.join(File.dirname(__FILE__), "apis/#{version}.yml")))
  end

  # @return [Api]
  def self.v3
    @v3 ||= init('3.0')
  end
end