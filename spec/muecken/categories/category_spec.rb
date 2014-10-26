require 'spec_helper'

describe Muecken::Categories::Category do
  let(:category) { Muecken::Categories::Category.new('foobar') }
  let(:entry) { Muecken::Entry.new }
  let(:rule) { Muecken::Categories::Rule.new }

  describe '#initialize' do
    it 'sets the name' do
      category.name.must_equal 'foobar'
    end
    it 'creates an empty rule list' do
      category.rules.must_equal []
    end
    it 'accepts an optional rule list' do
      category = Muecken::Categories::Category.new('foobar', [rule])
      category.rules.must_include rule
    end
  end

  describe '#add_rule' do
    it 'adds a rule' do
      category.add_rule rule
      category.rules.must_include rule
    end
    it 'rejects any non-rule object' do
      proc { category.add_rule(:foobar) }.must_raise ArgumentError
    end
  end

  describe '#match?' do
    let(:matching_rule) { Muecken::Categories::AlwaysMatchRule.new }
    let(:non_matching_rule_1) { Muecken::Categories::NeverMatchRule.new }
    let(:non_matching_rule_2) { Muecken::Categories::NeverMatchRule.new }
    it 'returns false if no rules are present' do
      category.match?(entry).must_equal false
    end
    it 'returns true if any rule matches' do
      category.add_rule non_matching_rule_1
      category.add_rule matching_rule
      category.add_rule non_matching_rule_2
      category.match?(entry).must_equal true
    end
    it 'returns false if no rule matches' do
      category.add_rule non_matching_rule_1
      category.add_rule non_matching_rule_2
      category.match?(entry).must_equal false
    end
  end

end
