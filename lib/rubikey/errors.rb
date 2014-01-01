module Rubikey
  class InvalidPasscode < StandardError
  end
  
  class InvalidKey < StandardError
  end
  
  class BadRedundancyCheck < StandardError
  end
end
