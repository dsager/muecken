module Muecken
  class Engine
    attr_accessor :categories, :entries

    def initialize
      @categories = []
      @entries = []
    end

    def categorize_entry(entry)
      categories.each do |category|
        entry.add_category(category) if category.match?(entry)
      end
      true
    end

    def add_entry(entry)
      entries << entry
    end

    def by_category(category)
      entries.select { |entry| entry.categories.include? category }
    end
  end
end
