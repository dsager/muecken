module Muecken
  module Categories
    class Category
      attr_reader :name, :rules

      def initialize(name_value, rules_value = nil)
        @name = name_value
        @rules = rules_value || []
      end

      def add_rule(rule)
        raise ArgumentError unless rule.class <= Rule
        @rules << rule
      end

      def match?(entry)
        rules.each do |rule|
          return true if rule.match?(entry)
        end
        false
      end
    end
  end
end
