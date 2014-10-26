module Muecken
  module Categories
    module Helper
      MONTHS = [
        :january, :february, :march, :april, :may, :june, :july, :august,
        :september, :october, :november, :december
      ]

      # creates a category for a
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
    end
  end
end
