require 'spec_helper'

describe Muecken::Matcher::Date do

  let(:day_matcher) { Muecken::Matcher::Date.new(:day, Date.today) }
  let(:month_matcher) { Muecken::Matcher::Date.new(:month, Date.today) }
  let(:year_matcher) { Muecken::Matcher::Date.new(:year, Date.today) }
  let(:weekday_matcher) { Muecken::Matcher::Date.new(:weekday, Date.today) }
  let(:invalid_mode_matcher) { Muecken::Matcher::Date.new(:foobar, Date.today) }
  let(:invalid_date_matcher) { Muecken::Matcher::Date.new(:day, :foobar) }

  describe '#initialize' do
    it('supports the :day mode') do
      day_matcher.must_be_instance_of Muecken::Matcher::Date
    end
    it 'supports the :month mode' do
      month_matcher.must_be_instance_of Muecken::Matcher::Date
    end
    it 'supports the :year mode' do
      year_matcher.must_be_instance_of Muecken::Matcher::Date
    end
    it 'supports the :weekday mode' do
      weekday_matcher.must_be_instance_of Muecken::Matcher::Date
    end
    it 'fails when passed an invalid mode' do
      proc { invalid_mode_matcher }.must_raise ArgumentError
    end
    it 'fails for unsupported modes' do
      proc { invalid_date_matcher }.must_raise ArgumentError
    end
  end

  describe '#match?' do
    let(:date) { Date.parse('2014-10-23') }
    let(:different_date) { Date.parse('1994-04-05') }
    let(:same_month) { date.next_day }
    let(:next_month) { date.next_month }
    let(:same_weekday) { date + 7 }
    let(:next_year) { date.next_year }

    let(:entry) { Muecken::Entry.from_hash(date: date) }
    let(:same_month_entry) { Muecken::Entry.from_hash(date: same_month) }
    let(:same_year_entry) { Muecken::Entry.from_hash(date: next_month) }
    let(:same_weekday_entry) { Muecken::Entry.from_hash(date: same_weekday) }
    let(:next_year_entry) { Muecken::Entry.from_hash(date: next_year) }
    let(:different_entry) { Muecken::Entry.from_hash(date: different_date) }


    it 'returns false when the first entry does not have a date' do
      day_matcher.match?(Muecken::Entry.new).must_equal false
    end

    describe 'in :day mode' do
      let(:matcher) { Muecken::Matcher::Date.new(:day, date) }
      it 'matches entries with the same day' do
        matcher.match?(entry).must_equal true
      end
      it 'does not match entries with different days' do
        matcher.match?(same_month_entry).must_equal false
        matcher.match?(same_year_entry).must_equal false
        matcher.match?(same_weekday_entry).must_equal false
        matcher.match?(next_year_entry).must_equal false
        matcher.match?(different_entry).must_equal false
      end
    end
    describe 'in :month mode' do
      let(:matcher) { Muecken::Matcher::Date.new(:month, date) }
      it 'matches entries with the same month' do
        matcher.match?(entry).must_equal true
        matcher.match?(same_month_entry).must_equal true
        matcher.match?(same_weekday_entry).must_equal true
        matcher.match?(next_year_entry).must_equal true
      end
      it 'does not match entries with different months' do
        matcher.match?(same_year_entry).must_equal false
        matcher.match?(different_entry).must_equal false
      end
    end
    describe 'in :year mode' do
      let(:matcher) { Muecken::Matcher::Date.new(:year, date) }
      it 'matches entries with the same year' do
        matcher.match?(entry).must_equal true
        matcher.match?(same_month_entry).must_equal true
        matcher.match?(same_weekday_entry).must_equal true
        matcher.match?(same_year_entry).must_equal true
      end
      it 'does not match entries with different years' do
        matcher.match?(next_year_entry).must_equal false
        matcher.match?(different_entry).must_equal false
      end
    end
    describe 'in :weekday mode' do
      let(:matcher) { Muecken::Matcher::Date.new(:weekday, date) }
      it 'matches entries with the same weekday' do
        matcher.match?(entry).must_equal true
        matcher.match?(same_weekday_entry).must_equal true
      end
      it 'does not match entries with different weekdays' do
        matcher.match?(same_month_entry).must_equal false
        matcher.match?(same_year_entry).must_equal false
        matcher.match?(next_year_entry).must_equal false
        matcher.match?(different_entry).must_equal false
      end
    end
  end

end
