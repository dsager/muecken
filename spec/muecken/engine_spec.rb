require 'spec_helper'

describe Muecken::Engine do

  let(:engine) { Muecken::Engine.new }
  let(:entry) { Muecken::Entry.new }
  let(:true_matcher) { Muecken::Matcher::AlwaysMatcher.new }
  let(:false_matcher) { Muecken::Matcher::NeverMatcher.new }
  let(:category_1) { Muecken::Categories::Base.new 'foo' }
  let(:rule_1) { Muecken::Rules::OneMatch.new([true_matcher], [category_1]) }
  let(:category_2) { Muecken::Categories::Base.new 'bar' }
  let(:rule_2) { Muecken::Rules::OneMatch.new([false_matcher], [category_2]) }

  describe '#initialize' do
    it 'creates an empty entry list' do
      engine.entries.must_be_instance_of Array
      engine.entries.must_be_empty
    end
    it 'creates an empty category list' do
      engine.categories.must_be_instance_of Array
      engine.categories.must_be_empty
    end
    it 'creates an empty rules list' do
      engine.rules.must_be_instance_of Array
      engine.rules.must_be_empty
    end
  end

  describe '#categorize_entry' do
    before do
      engine.rules = [rule_1, rule_2]
      engine.categorize_entry entry
    end
    it 'adds matching categories to an entry' do
      entry.categories.must_include category_1
    end
    it 'does not add non-matching categories to an entry' do
      entry.categories.wont_include category_2
    end
    it 'rejects any non-entry object' do
      proc { engine.categorize_entry :foobar }.must_raise ArgumentError
    end
  end

  describe '#add_entry' do
    before { engine.add_entry entry }
    it('adds an entry to the list') { engine.entries.must_include entry }
    it 'rejects any non-entry object' do
      proc { engine.add_entry :foobar }.must_raise ArgumentError
    end
  end

  describe '#add_category' do
    before { engine.add_category category_1 }
    it('adds a category to the list') do
      engine.categories.must_include category_1
    end
    it 'rejects any non-category object' do
      proc { engine.add_category :foobar }.must_raise ArgumentError
    end
  end

  describe '#categories=' do
    before { engine.categories = [category_1, category_2] }
    it('adds a category to the list') do
      engine.categories.must_include category_1
      engine.categories.must_include category_2
    end
    it 'rejects any non-array object' do
      proc { engine.categories = :foobar }.must_raise ArgumentError
    end
    it 'rejects any non-category object in the list' do
      proc { engine.categories = [category_1, :foo] }.must_raise ArgumentError
    end
  end

  describe '#by_category' do
    let(:some_entry) { Muecken::Entry.new }
    let(:another_entry) { Muecken::Entry.new }
    before do
      engine.categories = [category_1, category_2]
      some_entry.add_category category_1
      another_entry.add_category category_2
      engine.add_entry some_entry
      engine.add_entry another_entry
    end
    it 'returns all entries that have that category' do
      engine.by_category(category_1).must_include some_entry
      engine.by_category(category_2).must_include another_entry
    end
    it 'does not return entries without that category' do
      engine.by_category(category_1).wont_include another_entry
      engine.by_category(category_2).wont_include some_entry
    end
    it 'rejects any non-category object' do
      proc { engine.by_category :foobar }.must_raise ArgumentError
    end
  end

end
