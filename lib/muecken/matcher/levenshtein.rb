require 'levenshtein'

module Muecken
  module Matcher
    class Levensthein < Base
      attr_reader :max_distance

      def initialize(max_distance_value = 0.15)
        @max_distance = max_distance_value
      end

      def match?(entry_1, entry_2)
        distance = Levenshtein.normalized_distance(
          entry_1.description, entry_2.description, nil, {}
        )
        distance <= max_distance
      end
    end
  end
end
