module Muecken
  module Rules
    class AllMatch < Base
      def match?(entry)
        matcher.each { |_matcher| return false unless _matcher.match?(entry) }
        matcher.any?
      end
    end
  end
end
