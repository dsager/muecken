require 'spec_helper'

describe Muecken::Matcher::SubString do

  describe '#initialize' do
    it 'requires an array' do
      proc { Muecken::Matcher::SubString.new(:foobar) }.must_raise ArgumentError
    end
  end

  describe '#match?' do
    let(:sub_strings) { %w(foo bar baz) }
    let(:sub_strings_upcase) { sub_strings.map(&:upcase) }
    let(:matcher) { Muecken::Matcher::SubString.new(sub_strings) }
    let(:matcher_upcase) { Muecken::Matcher::SubString.new(sub_strings) }
    let(:entry_1) { Muecken::Entry.from_hash(description: 'xyz foo bar qsbaz') }
    let(:entry_2) { Muecken::Entry.from_hash(description: 'foobarbaz xyz') }
    let(:entry_3) { Muecken::Entry.from_hash(description: 'foo xyz qrs bar') }
    it 'matches entries that contain all the sub strings' do
      matcher.match?(entry_1).must_equal true
      matcher.match?(entry_2).must_equal true
    end
    it 'does not match entries that don\'t contain all sub strings' do
      matcher.match?(entry_3).must_equal false
    end
    it 'compares case-insensitively' do
      matcher_upcase.match?(entry_1).must_equal true
      matcher_upcase.match?(entry_2).must_equal true
      matcher_upcase.match?(entry_3).must_equal false
    end
  end

end
