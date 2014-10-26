require 'spec_helper'

describe Muecken::Matcher::Date do

  it 'supports the :day mode' do
    Muecken::Matcher::Date.new(:day).must_be_instance_of Muecken::Matcher::Date
  end

  it 'supports the :month mode' do
    Muecken::Matcher::Date.new(:month)
      .must_be_instance_of Muecken::Matcher::Date
  end

  it 'supports the :year mode' do
    Muecken::Matcher::Date.new(:year).must_be_instance_of Muecken::Matcher::Date
  end

  it 'supports the :weekday mode' do
    Muecken::Matcher::Date.new(:weekday)
      .must_be_instance_of Muecken::Matcher::Date
  end

  it 'fails for unsupported modes' do
    proc { Muecken::Matcher::Date.new(:foobar) }.must_raise ArgumentError
  end

  describe '#match?' do
    let(:date) { Date.parse('2014-10-23') }
    let(:different_date) { Date.parse('1994-04-05') }
    let(:reference_entry) { Muecken::Entry.from_hash(date: date) }
    let(:same_day_entry) { Muecken::Entry.from_hash(date: date.dup) }
    let(:same_month_entry) { Muecken::Entry.from_hash(date: date.next_day) }
    let(:same_year_entry) { Muecken::Entry.from_hash(date: date.next_month) }
    let(:same_weekday_entry) { Muecken::Entry.from_hash(date: date + 7) }
    let(:next_year_entry) { Muecken::Entry.from_hash(date: date.next_year) }
    let(:different_entry) { Muecken::Entry.from_hash(date: different_date ) }
    let(:matcher) { Muecken::Matcher::Date.new }
    it 'returns false when the first entry does not have a date' do
      matcher.match?(Muecken::Entry.new, reference_entry).must_equal false
    end
    it 'returns false when the second entry does not have a date' do
      matcher.match?(reference_entry, Muecken::Entry.new).must_equal false
    end
    describe 'in :day mode' do
      let(:matcher) { Muecken::Matcher::Date.new(:day) }
      it 'matches entries with the same day' do
        matcher.match?(reference_entry, same_day_entry).must_equal true
      end
      it 'does not match entries with different days' do
        matcher.match?(reference_entry, same_month_entry).must_equal false
        matcher.match?(reference_entry, same_year_entry).must_equal false
        matcher.match?(reference_entry, same_weekday_entry).must_equal false
        matcher.match?(reference_entry, next_year_entry).must_equal false
        matcher.match?(reference_entry, different_entry).must_equal false
      end
    end
    describe 'in :month mode' do
      let(:matcher) { Muecken::Matcher::Date.new(:month) }
      it 'matches entries with the same month' do
        matcher.match?(reference_entry, same_day_entry).must_equal true
        matcher.match?(reference_entry, same_month_entry).must_equal true
        matcher.match?(reference_entry, same_weekday_entry).must_equal true
        matcher.match?(reference_entry, next_year_entry).must_equal true
      end
      it 'does not match entries with different months' do
        matcher.match?(reference_entry, same_year_entry).must_equal false
        matcher.match?(reference_entry, different_entry).must_equal false
      end
    end
    describe 'in :year mode' do
      let(:matcher) { Muecken::Matcher::Date.new(:year) }
      it 'matches entries with the same year' do
        matcher.match?(reference_entry, same_day_entry).must_equal true
        matcher.match?(reference_entry, same_month_entry).must_equal true
        matcher.match?(reference_entry, same_weekday_entry).must_equal true
        matcher.match?(reference_entry, same_year_entry).must_equal true
      end
      it 'does not match entries with different years' do
        matcher.match?(reference_entry, next_year_entry).must_equal false
        matcher.match?(reference_entry, different_entry).must_equal false
      end
    end
    describe 'in :weekday mode' do
      let(:matcher) { Muecken::Matcher::Date.new(:weekday) }
      it 'matches entries with the same weekday' do
        matcher.match?(reference_entry, same_day_entry).must_equal true
        matcher.match?(reference_entry, same_weekday_entry).must_equal true
      end
      it 'does not match entries with different weekdays' do
        matcher.match?(reference_entry, same_month_entry).must_equal false
        matcher.match?(reference_entry, same_year_entry).must_equal false
        matcher.match?(reference_entry, next_year_entry).must_equal false
        matcher.match?(reference_entry, different_entry).must_equal false
      end
    end
  end

end
