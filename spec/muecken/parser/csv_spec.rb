require 'spec_helper'

describe Muecken::Parser::CSV do

  describe '#create_entry' do
    let(:date) { Date.today }
    let(:description) { 'Foo Bar Invoice Baz' }
    let(:value) { -123.45 }
    let(:currency) { 'EUR' }
    let(:row) { CSV.parse("#{date}, #{description}, #{value}, #{currency}") }
    it 'creates an entry from a CSV row' do
      entry = Muecken::Parser::CSV.create_entry(row.first)
      entry.date.must_equal date
      entry.description.must_equal description
      entry.value.must_equal value
      entry.currency.must_equal currency
    end
  end

  describe '#parse_file' do
    let(:file) { 'spec/fixtures/data.csv' }
    it 'reads a file and returns a list of entries' do
      entries = Muecken::Parser::CSV.read_file(file)
      entries.size.must_equal 4
    end
  end
end
