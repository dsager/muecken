require 'spec_helper'

describe Muecken::Parser::Entry do
  let(:fields) { Muecken::Parser::Entry::FIELDS }
  let(:entry) { Muecken::Parser::Entry.new }
  it 'exposes methods for all fields' do
    fields.each do |field|
      entry.must_respond_to field
      entry.must_respond_to "#{field}=".to_sym
    end
  end

  describe '#from_hash' do
    let(:data) do
      {
        date: Date.today,
        description: 'foo bar',
        value: 123.45,
        currency: 'EUR',
      }
    end
    it 'creates a new entry from hash' do
      new_entry = Muecken::Parser::Entry.from_hash(data)
      new_entry.date.must_equal data[:date]
      new_entry.description.must_equal data[:description]
      new_entry.value.must_equal data[:value]
      new_entry.currency.must_equal data[:currency]
    end
  end

  describe '#to_s' do
    before do
      entry.date = Date.today
      entry.value = 123.45
      entry.currency = 'EUR'
      entry.description = 'foo bar'
    end
    it 'returns a string represenation' do
      entry.to_s.must_include entry.date.to_s
      entry.to_s.must_include entry.value.to_s
      entry.to_s.must_include entry.currency
      entry.to_s.must_include entry.description
    end
  end
end
