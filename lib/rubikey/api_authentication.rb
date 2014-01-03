require_relative 'extensions/HTTParty_response_extensions'

module Rubikey
  class ApiAuthentication
    # https://github.com/Yubico/yubikey-val/wiki/ValidationProtocolV20

    include HTTParty
    using Rubikey::HTTPartyResponseExtensions
  
    attr_reader :status
    
    base_uri 'http://api.yubico.com/wsapi/2.0/'

    def initialize(args)
      raise ArgumentError, "API ID is required" if args[:api_id].nil?
      raise ArgumentError, "API Key is required" if args[:api_key].nil?

      @nonce = SecureRandom.hex(16)

      response = Rubikey::ApiAuthentication.get("/verify?otp=#{args[:unique_passcode]}&id=#{args[:api_id]}&nonce=#{@nonce}")

      if response.is_tempered?(args[:api_key], @nonce) 
        @status = 'BAD_REQUEST'
      else
        @status = response.parsed_response[/status=(.*)$/,1].strip
      end
    end
  end
end
