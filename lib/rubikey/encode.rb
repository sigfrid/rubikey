module Rubikey::Encode
  MODHEX_CHARS = 'cbdefghijklnrtuv'.split(//)
   
  refine String do
    def to_binary
      [self].pack('H*')
    end

    def to_hexadecimal
      unpack('H*')[0]
    end

    def is_hexadecimal?
      self =~ /^[0-9a-fA-F]+$/ ? true : false
    end

    def is_modified_hexadecimal?
      self =~ /^[cbdefghijklnrtuv]+$/ ? true : false
    end
    
    def modified_hexadecimal_to_binary
      raise ArgumentError, "Modified hexadecimal string length is not even" unless self.length.even?
      raise ArgumentError, "Sting is not modified hexadecimal" unless self.is_modified_hexadecimal?
      
      self.scan(/../).each_with_object('') do |pair, binary|
        binary << decode_to_binary(pair)
      end
    end
    
    def binary_to_modified_hexadecimal
      self.bytes.each_with_object('') do |byte, modhex|
        modhex << decode_to_modified_hexadecimal(byte)
      end
    end
    
    private
    
    def decode_to_binary(pair)
      (MODHEX_CHARS.index(pair[0]) * 16 + MODHEX_CHARS.index(pair[1])).chr
    end
    
    def decode_to_modified_hexadecimal(byte)
      MODHEX_CHARS[(byte >> 4) & 0xF] + MODHEX_CHARS[byte & 0xF]
    end
  end
end
