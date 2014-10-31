module Muecken
  module Rules
    module Builder
      MONTHS = [
        :january, :february, :march, :april, :may, :june, :july, :august,
        :september, :october, :november, :december
      ]

      # creates a rule for a certain month with a corresponding category
      # @param month [Symbol] the name of the month as a lowercase symbol
      # @return [Muecken::Rules::Base]
      def self.month_rule(month)
        raise ArgumentError unless MONTHS.include?(month)
        Muecken::Rules::OneMatch.new(
          [Muecken::Matcher::Date.new(:month, Date.parse(month.to_s))],
          [Muecken::Categories::Secondary.new(month.to_s.capitalize)]
        )
      end

      # Creates an array with one rule per month
      # @return [Muecken::Rules::Base[]]
      def self.month_rules
        MONTHS.map { |month| month_rule(month) }
      end

      # creates a rule for a certain year with an corresponging category
      # @param year [Integer] The year
      # @return [Muecken::Rules::Base]
      def self.year_rule(year)
        raise ArgumentError unless year.to_s =~ /^\d+$/
        Muecken::Rules::OneMatch.new(
          [Muecken::Matcher::Date.new(:year, Date.parse("#{year}-01-01"))],
          [Muecken::Categories::Secondary.new(year.to_s)]
        )
      end
    end
  end
end
