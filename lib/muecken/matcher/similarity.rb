require 'levenshtein'

module Muecken
  module Matcher
    class Similarity < Base
      attr_reader :max_distance, :reference_string

      def initialize(reference_value, max_distance_value = 0.15)
        @reference_string = reference_value.to_s
        @max_distance = max_distance_value
      end

      def match?(entry)
        Levenshtein.normalized_distance(entry.description, reference_string) <=
          max_distance
      end
    end
  end
end
