module Muecken
  module Categories
    class Category
      attr_reader :name, :rules

      def initialize(name_value)
        @name = name_value
        @rules = []
      end

      def add_rule(rule)
        raise ArgumentError unless rule.class <= Rule
        @rules << rule
      end
    end
  end
end
