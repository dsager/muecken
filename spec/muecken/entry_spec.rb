require 'spec_helper'

describe Muecken::Entry do

  let(:entry) do
    entry = Muecken::Entry.new
    entry.date = Date.today
    entry.value = 123.45
    entry.currency = 'EUR'
    entry.description = 'foo bar'
    entry
  end

  describe '.from_hash' do
    let(:data) do
      {
        date: Date.today - 1,
        description: 'foo baz',
        value: 67.89,
        currency: 'USD',
      }
    end
    it 'creates a new entry from hash' do
      new_entry = Muecken::Entry.from_hash(data)
      new_entry.date.must_equal data[:date]
      new_entry.description.must_equal data[:description]
      new_entry.value.must_equal data[:value]
      new_entry.currency.must_equal data[:currency]
    end
  end

  describe '#date=' do
    let(:date) { Date.today - 2 }
    it 'sets the date when given a Date' do
      entry.date = date
      entry.date.must_be_instance_of Date
      entry.date.must_equal date
    end
    it 'parses and sets the date when given a String' do
      entry.date = date.to_s
      entry.date.must_be_instance_of Date
      entry.date.must_equal date
    end
  end

  describe '#add_category' do
    let(:category) { Muecken::Categories::Base.new('foobar') }
    it 'adds a category' do
      entry.add_category category
      entry.categories.must_include category
    end
    it 'rejects any non-category object' do
      proc { entry.add_category(:foobar) }.must_raise ArgumentError
    end
  end

  describe '#to_hash' do
    it 'creates a hash representation of the entry' do
      data = entry.to_hash
      data[:date].must_equal entry.date
      data[:description].must_equal entry.description
      data[:value].must_equal entry.value
      data[:currency].must_equal entry.currency
    end
  end

  describe '#to_json' do
    it 'creates a json representation of the entry' do
      data = JSON.parse(entry.to_json)
      data['date'].must_equal entry.date.to_s
      data['description'].must_equal entry.description
      data['value'].must_equal entry.value
      data['currency'].must_equal entry.currency
    end
  end

  describe '#to_s' do
    it 'returns a string represenation' do
      entry.to_s.must_include entry.date.to_s
      entry.to_s.must_include entry.value.to_s
      entry.to_s.must_include entry.currency
      entry.to_s.must_include entry.description
    end
  end
end
