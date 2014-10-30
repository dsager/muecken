require 'spec_helper'

describe Muecken::Engine do

  let(:engine) { Muecken::Engine.new }
  let(:entry) { Muecken::Entry.new }
  let(:category_1) do
    Muecken::Categories::Category.new 'foo',
      [Muecken::Categories::AlwaysMatchRule.new]
  end
  let(:category_2) do
    Muecken::Categories::Category.new 'bar',
      [Muecken::Categories::NeverMatchRule.new]
  end

  describe '#initialize' do
    it 'creates an empty entry list' do
      engine.entries.must_be_instance_of Array
      engine.entries.must_be_empty
    end
    it 'creates an empty category list' do
      engine.categories.must_be_instance_of Array
      engine.categories.must_be_empty
    end
  end

  describe '#categorize_entry' do
    before do
      engine.categories = [category_1, category_2]
      engine.categorize_entry entry
    end
    it 'adds matching categories to an entry' do
      entry.categories.must_include category_1
    end
    it 'does not add non-matching categories to an entry' do
      entry.categories.wont_include category_2
    end
  end

  describe '#add_entry' do
    before { engine.add_entry entry }
    it('adds an entry to the list') { engine.entries.must_include entry }
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
  end

end
