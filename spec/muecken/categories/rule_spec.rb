require 'spec_helper'

describe Muecken::Categories::Rule do
  let(:example_1) { Muecken::Entry.new }
  let(:example_2) { Muecken::Entry.new }
  let(:example_3) { Muecken::Entry.new }
  let(:rule) { Muecken::Categories::Rule.new }
  let(:matcher) { Muecken::Matcher::Base.new }

  describe '#initialize' do
    it 'creates an empty example list' do
      rule.examples.must_equal []
    end
    it 'optionally accepts a matcher' do
      another_rule = Muecken::Categories::Rule.new(matcher)
      another_rule.matcher.must_equal matcher
    end
  end

  describe '#matcher=' do
    it 'sets the matcher' do
      rule.matcher = matcher
      rule.matcher.must_equal matcher
    end
    it 'rejects any non-matcher object' do
      proc { rule.matcher = :foobar }.must_raise ArgumentError
    end
  end

  describe '#add_example' do
    it 'adds the example' do
      rule.add_example example_1
      rule.examples.must_include example_1
    end
    it 'rejects any non-entry object' do
      proc { rule.add_example :foobar }.must_raise ArgumentError
    end
  end

  describe '#match?' do
    let(:true_matcher) do
      Muecken::Matcher::ConsecutiveTest.new([false, true])
    end
    let(:false_matcher) do
      Muecken::Matcher::ConsecutiveTest.new([false, false])
    end
    it 'returns true if one example matches' do
      rule.add_example example_1
      rule.add_example example_2
      rule.matcher = true_matcher
      rule.match?(example_3).must_equal true
    end
    it 'returns false if no example matches' do
      rule.add_example example_1
      rule.add_example example_2
      rule.matcher = false_matcher
      rule.match?(example_3).must_equal false
    end
    it 'fails is no matcher is specified' do
      proc { rule.match? example_1 }.must_raise ScriptError
    end
    it 'rejects any non-entry object' do
      rule.matcher = matcher
      proc { rule.add_example :foobar }.must_raise ArgumentError
    end
  end

end
