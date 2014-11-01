require 'spec_helper'

module Rules
  module BaseSpec
    def self.included(_)
      describe 'Base' do

        let(:rule) { subject.new }
        let(:matcher) { Muecken::Matcher::Base.new }
        let(:rule_w_matcher) { subject.new([matcher]) }
        let(:category) { Muecken::Categories::Base.new('foobar') }
        let(:rule_w_category) { subject.new([], [category]) }
        let(:entry) { Muecken::Entry.new }

        describe '#initialize' do
          it('creates an empty matcher list') { rule.matcher.must_equal [] }
          it('creates an empty category list') { rule.categories.must_equal [] }
          it 'accepts an optional matcher list' do
            rule_w_matcher.matcher.must_include matcher
          end
          it 'accepts an optional category list' do
            rule_w_category.categories.must_include category
          end
        end

        describe '#add_matcher' do
          before { rule.add_matcher matcher }
          it('adds the matcher') { rule.matcher.must_include matcher }
          it 'rejects any non-matcher object' do
            proc { rule.add_matcher :foobar }.must_raise ArgumentError
          end
        end

        describe '#add_category' do
          before { rule.add_category category }
          it('adds the category') { rule.categories.must_include category }
          it 'rejects any non-category object' do
            proc { rule.add_category :foobar }.must_raise ArgumentError
          end
        end

        describe '#apply' do
          it 'fails is no matcher is specified' do
            proc { rule.apply entry }.must_raise ScriptError
          end
          it 'rejects any non-entry object' do
            proc { rule_w_matcher.apply :foobar }.must_raise ArgumentError
          end
          it 'returns false if it doesn\'t match the entry' do
            rule_w_matcher.stub(:match?, false) do
              rule_w_matcher.apply(entry).must_equal false
            end
          end
          let(:matching_rule) do
            subject.new([matcher], [category, category.dup])
          end
          it 'assigns all categories to the entry if it matches' do
            matching_rule.stub(:match?, true) do
              matching_rule.apply(entry).must_equal true
              entry.categories.must_include category
              entry.categories.count.must_equal 2
            end
          end
        end
      end
    end
  end
end

describe Muecken::Rules::Base do
  subject { Muecken::Rules::Base }
  include Rules::BaseSpec

  describe '#match?' do
    it 'raises an not implemented error' do
      proc { subject.new.match? :entry }.must_raise NotImplementedError
    end
  end
end
