module Muecken
  class Engine
    attr_reader :categories, :entries, :rules

    def initialize
      @categories = []
      @entries = []
      @rules = []
    end

    def categorize_entry(entry)
      raise ArgumentError unless entry.class <= Muecken::Entry
      rules.each { |rule| rule.apply(entry) }
      true
    end

    def add_entry(entry)
      raise ArgumentError unless entry.class <= Muecken::Entry
      entries << entry
    end

    def add_rule(rule)
      raise ArgumentError unless rule.class <= Rules::Base
      unless rules.include? rule
        rules << rule
        extract_categories_from_rule(rule)
      end
    end

    def rules=(rules)
      raise ArgumentError unless rules.class <= Array
      rules.each { |rule| add_rule rule }
    end

    def add_category(category)
      raise ArgumentError unless category.class <= Categories::Base
      categories << category unless categories.include? category
    end

    def categories=(categories)
      raise ArgumentError unless categories.class <= Array
      categories.each { |category| add_category category }
    end

    def by_category(category)
      raise ArgumentError unless category.class <= Categories::Base
      entries.select { |entry| entry.categories.include? category }
    end

    def extract_categories_from_rule(rule)
      raise ArgumentError unless rule.class <= Rules::Base
      rule.categories.each do |category|
        add_category category
      end
    end
  end
end
