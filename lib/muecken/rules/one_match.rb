module Muecken
  module Rules
    class OneMatch < Base
      def match?(entry)
        matcher.each { |_matcher| return true if _matcher.match?(entry) }
        false
      end
    end
  end
end
