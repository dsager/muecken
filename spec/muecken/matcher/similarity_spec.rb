require 'spec_helper'

describe Muecken::Matcher::Similarity do

  let(:reference) { 'foo bar baz ' * 5 }
  let(:entry_1) { Muecken::Entry.from_hash(description: 'foo bar bar ' * 5) }
  let(:entry_2) { Muecken::Entry.from_hash(description: 'boo far faz ' * 5) }
  let(:entry_3) { Muecken::Entry.from_hash(description: 'xyz qrs tuv ' * 5) }

  describe '#match?' do
    let(:matcher) { Muecken::Matcher::Similarity.new(reference) }
    it 'matches entries with similar descriptions' do
      matcher.match?(entry_1).must_equal true
    end
    it 'does not match entries with different descriptions' do
      matcher.match?(entry_2).must_equal false
      matcher.match?(entry_3).must_equal false
    end
    describe 'when set to be more tolerant' do
      let(:matcher) { Muecken::Matcher::Similarity.new(reference, 0.5) }
      it 'matches entries with slightly different descriptions' do
        matcher.match?(entry_1).must_equal true
        matcher.match?(entry_2).must_equal true
      end
      it 'does not match entries with very different descriptions' do
        matcher.match?(entry_3).must_equal false
      end
    end
  end

end
