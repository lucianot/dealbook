require 'spec_helper'

describe Market do
  before(:each) { @market = Market.make }
  subject { @market }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Invalid name
  context 'when :name is' do

    context 'not present' do
      before { @market.name = nil }
      it { should_not be_valid }
    end 

    context 'too short' do
      before { @market.name = 'a' }
      it { should_not be_valid }
    end 

    context 'too long' do
      before { @market.name = 'a'*101 }
      it { should_not be_valid }
    end 

    context 'not unique' do
      before { Market.make!(:name => @market.name) }
      it { should_not be_valid }
    end

  end
end
