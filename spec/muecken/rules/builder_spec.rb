require 'spec_helper'

describe Muecken::Rules::Builder do

  subject { Muecken::Rules::Builder }

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

  let(:jul_entry_2013) do
    Muecken::Entry.from_hash(date: jul_entry.date.prev_year)
  end

  describe 'self.month_rule' do
    let(:july_rule) { subject.month_rule(:july) }
    it 'creates a rule with a category of a certain month' do
      july_rule.categories.first.name.must_equal 'July'
    end
    it 'creates a rule that matches entries from a certain month' do
      july_rule.match?(jul_entry).must_equal true
      july_rule.match?(jul_entry_2013).must_equal true
    end
    it 'creates a rule that does not match entries from a other months' do
      july_rule.match?(may_entry).must_equal false
      july_rule.match?(sep_entry).must_equal false
    end
    it 'raises an error for invalid months' do
      proc { subject.month_rule(:foo_bar) }.must_raise ArgumentError
    end
  end

  describe 'self.month_categories' do
    let(:rules) { subject.month_rules }
    it('creates a list of 12 categories') { rules.count.must_equal 12 }
    it 'creates a rule for January' do
      rules[0].categories.first.name.must_equal 'January'
      rules[0].match?(jan_entry).must_equal true
    end
    it 'creates a rule for February' do
      rules[1].categories.first.name.must_equal 'February'
      rules[1].match?(feb_entry).must_equal true
    end
    it 'creates a rule for March' do
      rules[2].categories.first.name.must_equal 'March'
      rules[2].match?(mar_entry).must_equal true
    end
    it 'creates a rule for April' do
      rules[3].categories.first.name.must_equal 'April'
      rules[3].match?(apr_entry).must_equal true
    end
    it 'creates a rule for May' do
      rules[4].categories.first.name.must_equal 'May'
      rules[4].match?(may_entry).must_equal true
    end
    it 'creates a rule for June' do
      rules[5].categories.first.name.must_equal 'June'
      rules[5].match?(jun_entry).must_equal true
    end
    it 'creates a rule for July' do
      rules[6].categories.first.name.must_equal 'July'
      rules[6].match?(jul_entry).must_equal true
    end
    it 'creates a rule for August' do
      rules[7].categories.first.name.must_equal 'August'
      rules[7].match?(aug_entry).must_equal true
    end
    it 'creates a rule for September' do
      rules[8].categories.first.name.must_equal 'September'
      rules[8].match?(sep_entry).must_equal true
    end
    it 'creates a rule for October' do
      rules[9].categories.first.name.must_equal 'October'
      rules[9].match?(oct_entry).must_equal true
    end
    it 'creates a rule for November' do
      rules[10].categories.first.name.must_equal 'November'
      rules[10].match?(nov_entry).must_equal true
    end
    it 'creates a rule for December' do
      rules[11].categories.first.name.must_equal 'December'
      rules[11].match?(dec_entry).must_equal true
    end
  end

  describe 'self.year_rule' do
    let(:rule_2013) { subject.year_rule(2013) }
    let(:rule_2014) { subject.year_rule(2014) }
    it 'creates a category with the name of a certain year' do
      rule_2013.categories.first.name.must_equal '2013'
      rule_2014.categories.first.name.must_equal '2014'
    end
    it 'creates a rule that matches entries from a certain year' do
      rule_2013.match?(jul_entry_2013).must_equal true
      rule_2014.match?(jul_entry).must_equal true
    end
    it 'creates a rule that does not match entries from a other years' do
      rule_2013.match?(jul_entry).must_equal false
      rule_2014.match?(jul_entry_2013).must_equal false
    end
    it 'raises an error for invalid years' do
      proc { subject.year_rule(:foo) }
        .must_raise ArgumentError
    end
  end

end
