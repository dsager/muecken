module Muecken
  module Matcher
    class SubString < Base
      attr_reader :sub_strings

      def initialize(sub_strings_value)
        raise ArgumentError unless sub_strings_value.class <= Array
        @sub_strings = sub_strings_value.map { |val| val.to_s.strip.downcase }
      end

      def match?(entry)
        desc = entry.description.to_s.strip.downcase
        sub_strings.each do |sub_string|
          return false unless desc.index sub_string
        end
        true
      end
    end
  end
end
