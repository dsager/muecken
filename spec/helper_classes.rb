module Muecken
  module Matcher
    class InvalidMatcherClass < Base
    end
    class AlwaysMatcher < Base
      def match?(_)
        true
      end
    end
    class NeverMatcher < Base
      def match?(_)
        false
      end
    end
  end
end
