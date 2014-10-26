module Muecken
  module Categories
    class Rule
      attr_reader :examples, :matcher

      def initialize(matcher_value = nil, examples_value = nil)
        @examples = examples_value || []
        self.matcher = matcher_value unless matcher_value.nil?
      end

      def matcher=(matcher_value)
        raise ArgumentError unless matcher_value.class <= Muecken::Matcher::Base
        @matcher = matcher_value
      end

      def add_example(example_entry)
        raise ArgumentError unless example_entry.class <= Muecken::Entry
        examples << example_entry
      end

      def match?(entry)
        raise ScriptError, 'no matcher specified' if matcher.nil?
        raise ArgumentError unless entry.class <= Muecken::Entry
        examples.each do |example_entry|
          return true if matcher.match?(entry, example_entry)
        end
        false
      end
    end
  end
end
