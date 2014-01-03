
require_relative 'extensions/encoding_extensions'
require_relative 'extensions/string_extensions'

module Rubikey
  class KeyConfig
    using Rubikey::EncodingExtensions
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
