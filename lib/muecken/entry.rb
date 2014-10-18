require 'json'

module Muecken
  # An entry represents a financial transaction.
  class Entry
    attr_accessor :description, :value, :currency
    attr_reader :date, :categories

    # @return [Entry]
    def initialize
      @categories = []
    end

    # create a new entry from hash. keys are expected to be symbols.
    # @param [Hash] data
    # @return [Entry]
    def self.from_hash(data)
      entry = new
      entry.date = data[:date] if data[:date]
      entry.description = data[:description] if data[:description]
      entry.value = data[:value] if data[:value]
      entry.currency = data[:currency] if data[:currency]
      entry
    end

    # set the date, in case it's a string it will be passed to Date.parse().
    # @param [Date|String] date_value
    # @return [Date]
    def date=(date_value)
      @date = date_value.class <= Date ? date_value : Date.parse(date_value)
    end

    # add a new category.
    # @param [Categories::Category] category
    # @return [Categories::Category]
    def add_category(category)
      raise ArgumentError unless category.class <= Categories::Category
      @categories << category
    end

    # create a String representation of this entry.
    # @return [String]
    def to_s
      "[#{date}] #{currency} #{value} - #{description}"
    end

    # create a Hash representation of this entry.
    # @return [Hash]
    def to_hash
      {
        date: date,
        description: description,
        value: value,
        currency: currency,
      }
    end

    # create a JSON string of this entry.
    # @return [String]
    def to_json
      to_hash.to_json
    end
  end
end
