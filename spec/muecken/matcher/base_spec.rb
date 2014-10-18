require 'spec_helper'

describe Muecken::Matcher::Base do

  describe '#match?' do
    let(:invalid_matcher) { Muecken::Matcher::InvalidMatcherClass.new }
    it 'fails when not overwritten' do
      proc { invalid_matcher.match?(:foo, :bar) }.must_raise NotImplementedError
    end
  end

end
