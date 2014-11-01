module Muecken
  module Rules
    class Base
      attr_reader :matcher, :categories

      def initialize(matcher_value = [], categories_value = [])
        raise ArgumentError unless matcher_value.class <= Array
        raise ArgumentError unless categories_value.class <= Array
        @matcher = []
        matcher_value.each { |matcher| add_matcher matcher }
        @categories = []
        categories_value.each { |category| add_category category }
      end

      def add_matcher(matcher_value)
        raise ArgumentError unless matcher_value.class <= Muecken::Matcher::Base
        matcher << matcher_value
      end

      def add_category(category_value)
        raise ArgumentError unless category_value.class <= Muecken::Categories::Base
        categories << category_value
      end

      def apply(entry)
        raise ScriptError, 'no matcher specified' if matcher.empty?
        raise ArgumentError unless entry.class <= Muecken::Entry
        match?(entry) ? matched(entry) : false
      end

      def match?(entry)
        raise NotImplementedError
      end

      protected

      def matched(entry)
        categories.each { |category| entry.add_category category }
        true
      end
    end
  end
end
