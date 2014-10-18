module Muecken
  module Matcher
    class ConsecutiveTest < Base
      def initialize(results = [])
        @results = results
      end
      def match?(entry_1, entry_2)
        !!@results.shift
      end
    end
    class InvalidMatcherClass < Muecken::Matcher::Base
    end
  end
  module Categories
    class AlwaysMatchRule < Rule
      def match?(entry)
        true
      end
    end
    class NeverMatchRule < Rule
      def match?(entry)
        false
      end
    end
  end
end
