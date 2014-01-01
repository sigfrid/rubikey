module Rubikey::StringExtensions
  refine String do
    def strip_prefix
      self[-32,32]
    end
    
    def key_identifier
      self[0,12]
    end
  end
end