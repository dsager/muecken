require 'spec_helper'

describe Muecken::Categories::Helper do

  let(:jan_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-01-01')) }
  let(:feb_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-02-13')) }
  let(:mar_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-03-21')) }
  let(:apr_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-04-29')) }
  let(:may_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-05-11')) }
  let(:jun_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-06-17')) }
  let(:jul_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-07-04')) }
  let(:aug_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-08-06')) }
  let(:sep_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-09-24')) }
  let(:oct_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-10-19')) }
  let(:nov_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-11-03')) }
  let(:dec_entry) { Muecken::Entry.from_hash(date: Date.parse('2014-12-24')) }

  describe 'self.month_category' do
    let(:another_jul_entry) do
      Muecken::Entry.from_hash(date: jul_entry.date.prev_year)
    end
    let(:july_category) { Muecken::Categories::Helper.month_category(:july) }
    it 'creates a category with the name of a certain month' do
      july_category.name.must_equal 'July'
    end
    it 'creates a category that matches entries from a certain month' do
      july_category.match?(jul_entry).must_equal true
      july_category.match?(another_jul_entry).must_equal true
    end
    it 'creates a category that does not match entries from a other months' do
      july_category.match?(may_entry).must_equal false
      july_category.match?(sep_entry).must_equal false
    end
    it 'raises an error for invalid months' do
      proc { Muecken::Categories::Helper.month_category(:foo_bar) }
        .must_raise ArgumentError
    end
  end

  describe 'self.month_categories' do
    let(:categories) { Muecken::Categories::Helper.month_categories }
    it('creates a list of 12 categories') { categories.count.must_equal 12 }
    it 'creates a category for January' do
      categories[0].name.must_equal 'January'
      categories[0].match?(jan_entry).must_equal true
    end
    it 'creates a category for February' do
      categories[1].name.must_equal 'February'
      categories[1].match?(feb_entry).must_equal true
    end
    it 'creates a category for March' do
      categories[2].name.must_equal 'March'
      categories[2].match?(mar_entry).must_equal true
    end
    it 'creates a category for April' do
      categories[3].name.must_equal 'April'
      categories[3].match?(apr_entry).must_equal true
    end
    it 'creates a category for May' do
      categories[4].name.must_equal 'May'
      categories[4].match?(may_entry).must_equal true
    end
    it 'creates a category for June' do
      categories[5].name.must_equal 'June'
      categories[5].match?(jun_entry).must_equal true
    end
    it 'creates a category for July' do
      categories[6].name.must_equal 'July'
      categories[6].match?(jul_entry).must_equal true
    end
    it 'creates a category for August' do
      categories[7].name.must_equal 'August'
      categories[7].match?(aug_entry).must_equal true
    end
    it 'creates a category for September' do
      categories[8].name.must_equal 'September'
      categories[8].match?(sep_entry).must_equal true
    end
    it 'creates a category for October' do
      categories[9].name.must_equal 'October'
      categories[9].match?(oct_entry).must_equal true
    end
    it 'creates a category for November' do
      categories[10].name.must_equal 'November'
      categories[10].match?(nov_entry).must_equal true
    end
    it 'creates a category for December' do
      categories[11].name.must_equal 'December'
      categories[11].match?(dec_entry).must_equal true
    end
  end

end
