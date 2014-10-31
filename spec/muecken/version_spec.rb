require 'spec_helper'

module VersionSpec
  def self.included(_)
    describe 'version' do
      let(:version) { subject }
      let(:split) { version.split('.') }
      it 'is semantic' do
        version.must_be_instance_of String
        (split.count >= 3).must_equal true
        split[0].must_match /^\d+$/
        split[1].must_match /^\d+$/
        split[2].must_match /^\d+$/
      end
    end
  end
end

# describe Muecken::VERSION do
#   subject { Muecken::VERSION }
#   include VersionSpec
# end

describe Muecken.version do
  subject { Muecken.version }
  include VersionSpec
end
