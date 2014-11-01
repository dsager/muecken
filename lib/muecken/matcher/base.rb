module Muecken
  module Matcher
    class Base
      def match?(entry)
        raise NotImplementedError
      end
    end
  end
end
