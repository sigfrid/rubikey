module Rubikey::StringExtensions
  refine String do
    def last(n)
      self[-n,n]
    end
    
    def first(n)
      self[0,n]
    end
  end
end