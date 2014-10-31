require 'spec_helper'

module Categories
  module BaseSpec
    def self.included(_)
      describe '#initialize' do
        let(:category_name) { 'foobar' }
        let(:category) { subject.new(category_name) }
        it('sets the name') { category.name.must_equal category_name }
      end
    end
  end
end

describe Muecken::Categories::Base do
  subject { Muecken::Categories::Base }
  include Categories::BaseSpec
end
