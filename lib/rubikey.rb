require "rubikey/version"

require "rubikey/errors"
require "rubikey/encode"
require "rubikey/string_extensions"

module Rubikey
  class OTP
    using Rubikey::Encode

    attr_reader :unique_passcode
    
    def initialize(unique_passcode)
      raise InvalidPasscode, 'Passcode must be at least 32 modified hexadecimal characters' unless unique_passcode.is_modified_hexadecimal? && unique_passcode.length >= 32

      @unique_passcode = unique_passcode
    end

    def config(secret_key)
      KeyConfig.new(unique_passcode, secret_key)
    end
  end

  class KeyConfig
    using Rubikey::Encode
    using Rubikey::StringExtensions

    attr_reader :public_id
    attr_reader :secret_id
    attr_reader :insert_counter
     
    def initialize(unique_passcode, secret_key)
      raise InvalidKey, 'Secret key must be 32 hexadecimal characters' unless secret_key.is_hexadecimal? && secret_key.length == 32
      
      @unique_passcode = unique_passcode
      @public_id = @unique_passcode.first(12)
    
      decrypter = OpenSSL::Cipher.new('AES-128-ECB').decrypt
      decrypter.key = secret_key.hexadecimal_to_binary
      decrypter.padding = 0
      @token = decrypter.update(base) + decrypter.final
         
      raise BadRedundancyCheck unless cyclic_redundancy_check_is_valid? 
      
      @secret_id, @insert_counter, timestamp, timestamp_lo, session_counter, random_number, crc = @token.unpack('H12vvCCvv')
    end 
    
    private

    def base
      @unique_passcode.last(32).modified_hexadecimal_to_binary
    end

    def cyclic_redundancy_check_is_valid? 
      crc = 0xffff
      @token.each_byte do |byte|
        crc ^= byte & 0xff
        8.times do
          test = (crc & 1) == 1
          crc >>= 1
          crc ^= 0x8408 if test
        end
      end
      crc == 0xf0b8
    end  
  end
end
