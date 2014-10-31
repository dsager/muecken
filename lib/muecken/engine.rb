module Muecken
  class Engine
    attr_reader :categories, :entries

    def initialize
      @categories = []
      @entries = []
    end

    def categorize_entry(entry)
      raise ArgumentError unless entry.class <= Muecken::Entry
      categories.each do |category|
        entry.add_category(category) if category.match?(entry)
      end
      true
    end

    def add_entry(entry)
      raise ArgumentError unless entry.class <= Muecken::Entry
      entries << entry
    end

    def add_category(category)
      raise ArgumentError unless category.class <= Categories::Category
      categories << category
    end

    def categories=(categories)
      raise ArgumentError unless categories.class <= Array
      categories.each { |category| add_category category }
    end

    def by_category(category)
      raise ArgumentError unless category.class <= Categories::Category
      entries.select { |entry| entry.categories.include? category }
    end
  end
end
