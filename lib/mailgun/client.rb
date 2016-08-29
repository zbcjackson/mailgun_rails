require 'rest_client'
require 'mailgun/logging'

module Mailgun
  class Client
    include Logging
    attr_reader :api_key, :domain

    def initialize(api_key, domain)
      @api_key = api_key
      @domain = domain
    end

    def send_message(options)
      begin
        logger.info 'Sending request to mailgun'
        logger.debug "with options #{options}"
        response = RestClient.post mailgun_url, options
        logger.info 'Successfully sent request to mailgun'
        response
      rescue => e
        logger.error e.message
        logger.error e.response
      end
    end

    def mailgun_url
      api_url+"/messages"
    end

    def api_url
      "https://api:#{api_key}@api.mailgun.net/v3/#{domain}"
    end
  end
end
