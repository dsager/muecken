require 'spec_helper'
require_relative 'base_spec'

describe Muecken::Rules::OneMatch do
  subject { Muecken::Rules::OneMatch }
  include Rules::BaseSpec

  describe '#match?' do
    let(:true_matcher) { Muecken::Matcher::AlwaysMatcher.new }
    let(:false_matcher) { Muecken::Matcher::NeverMatcher.new }
    let(:entry) { Muecken::Entry.new }

    describe 'when no matcher is present' do
      let(:rule) { subject.new }
      it('returns false') { rule.match?(entry).must_equal false }
    end

    describe 'when all matcher match' do
      let(:rule) { subject.new([true_matcher, true_matcher.dup]) }
      it('returns true') { rule.match?(entry).must_equal true }
    end

    describe 'when one matcher does not match' do
      let(:rule) { subject.new([true_matcher, false_matcher]) }
      it('returns true') { rule.match?(entry).must_equal true }
    end

    describe 'when no matcher matches' do
      let(:rule) { subject.new([false_matcher, false_matcher.dup]) }
      it('returns false') { rule.match?(entry).must_equal false }
    end
  end
end
