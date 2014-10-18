module Muecken
  module Matcher
    class Base
      def match?(entry_1, entry_2)
        raise NotImplementedError
      end
    end
  end
end
