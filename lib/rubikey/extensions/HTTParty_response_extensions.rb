require 'httparty'

module Rubikey::HTTPartyResponseExtensions
  refine HTTParty::Response do
    def is_tempered?(api_key, nonce)
      if /nonce=(.+)$/.match self.parsed_response
        tempered_signature?(api_key)|| tempered_nonce?(nonce)
      else
        tempered_signature?(api_key)
      end
    end

    def tempered_signature?(api_key)
      response_signature != Rubikey::HTTPartyResponseExtensions::Hmac.new(self.parsed_response, api_key).value
    end

    def tempered_nonce?(nonce)
      nonce != response_nonce
    end

    def response_signature
      self.parsed_response[/^h=(.+)$/, 1].strip
    end

    def response_nonce
      self.parsed_response[/nonce=(.+)$/, 1].strip 
    end
  end

  class Hmac
    attr_reader :value
  
    def initialize(response, api_key)
      response_params = remove_signature_from(response)
      response_string = stringify(response_params)
      response_string.strip!

      hmac = OpenSSL::HMAC.digest('sha1', Base64.decode64(api_key), response_string)
      @value = Base64.encode64(hmac).strip
    end

    def remove_signature_from(response)
       response.sub(/^h=(.+)$/, '').split(' ')
    end

    def stringify(params) 
      params.sort.join('&')
    end

  end
end
