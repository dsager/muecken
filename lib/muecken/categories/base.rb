module Muecken
  module Categories
    class Base
      attr_reader :name

      def initialize(name_value)
        @name = name_value
      end
    end
  end
end
