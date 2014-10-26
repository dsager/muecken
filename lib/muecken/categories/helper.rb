module Muecken
  module Categories
    module Helper
      MONTHS = [
        :january, :february, :march, :april, :may, :june, :july, :august,
        :september, :october, :november, :december
      ]

      # creates a category for a certain month with an initialized matcher
      # @param month [Symbol] the name of the month as a lowercase symbol
      # @return [Muecken::Categories::Category]
      def self.month_category(month)
        raise ArgumentError unless MONTHS.include?(month)
        rule = Rule.new(
          Muecken::Matcher::Date.new(:month),
          [Muecken::Entry.from_hash(date: Date.parse(month.to_s))]
        )
        Muecken::Categories::Category.new(month.to_s.capitalize, [rule])
      end

      # Creates an array with one category per month
      # @return [Array]
      def self.month_categories
        MONTHS.map { |month| month_category(month) }
      end

      # creates a category for a certain year with an initialized matcher
      # @param year [Integer] The year
      # @return [Muecken::Categories::Category]
      def self.year_category(year)
        raise ArgumentError unless year.to_s =~ /^\d+$/
        rule = Rule.new(
          Muecken::Matcher::Date.new(:year),
          [Muecken::Entry.from_hash(date: Date.parse("#{year}-01-01"))]
        )
        Muecken::Categories::Category.new(year.to_s, [rule])
      end
    end
  end
end
