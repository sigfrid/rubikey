require_relative 'extensions/encoding_extensions'

module Rubikey
  class OTP
    using Rubikey::EncodingExtensions

    attr_reader :unique_passcode
    
    def initialize(unique_passcode)
      raise InvalidPasscode, 'Passcode must be at least 32 modified hexadecimal characters' unless unique_passcode.is_modified_hexadecimal? && unique_passcode.length >= 32

      @unique_passcode = unique_passcode
    end

    def config(secret_key)
      Rubikey::KeyConfig.new(unique_passcode, secret_key)
    end

    def authenticate(args)
      Rubikey::ApiAuthentication.new(api_id: args[:api_id], api_key: args[:api_key], unique_passcode: @unique_passcode)
    end
  end
end
