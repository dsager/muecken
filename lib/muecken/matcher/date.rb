module Muecken
  module Matcher
    # Matches entries based on their dates.
    #
    # Different modes are supported:
    # :day     - entries that happened on the same day
    # :month   - entries that happened during the same month, no matter the year
    # :year    - entries that happened during the same year
    # :weekday - entries that happened on the same weekday
    #
    class Date < Base
      MODES = [:day, :month, :year, :weekday]
      attr_reader :mode

      # @param mode_value [Symbol] One of the supported modes, defaults to :day
      def initialize(mode_value = :day)
        raise ArgumentError unless MODES.include? mode_value
        @mode = mode_value
      end

      # @param entry_1 [Muecken::Entry]
      # @param entry_2 [Muecken::Entry]
      # @return [Boolean]
      def match?(entry_1, entry_2)
        unless entry_1.date.is_a?(::Date) && entry_2.date.is_a?(::Date)
          return false
        end
        send("#{mode}_matches?".to_sym, entry_1.date, entry_2.date)
      end

      private

      def day_matches?(date_1, date_2)
        date_1 == date_2
      end

      def month_matches?(date_1, date_2)
        date_1.month == date_2.month
      end

      def year_matches?(date_1, date_2)
        date_1.year == date_2.year
      end

      def weekday_matches?(date_1, date_2)
        date_1.cwday == date_2.cwday
      end
    end
  end
end
