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
      attr_reader :mode, :reference_date

      # @param mode_value [Symbol] One of the supported modes
      # @param reference_date_value [Date] A reference date used for matching
      def initialize(mode_value, reference_date_value)
        raise ArgumentError unless MODES.include? mode_value
        raise ArgumentError unless reference_date_value.is_a?(::Date)
        @mode = mode_value
        @reference_date = reference_date_value
      end

      # @param entry [Muecken::Entry]
      # @return [Boolean]
      def match?(entry)
        return false unless entry.date.is_a?(::Date)
        send("#{mode}_matches?".to_sym, entry.date)
      end

      private

      def day_matches?(date)
        date == reference_date
      end

      def month_matches?(date)
        date.month == reference_date.month
      end

      def year_matches?(date)
        date.year == reference_date.year
      end

      def weekday_matches?(date)
        date.cwday == reference_date.cwday
      end
    end
  end
end
