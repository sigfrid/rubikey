module Rubikey::Encode
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
  end
end
