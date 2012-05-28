require 'spec_helper'

describe Location do
  before(:each) { @location = Location.make }
  subject { @location }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Invalid country
  context 'when :country is' do

    context 'not present' do
      before { @location.country = nil }
      it { should_not be_valid }
    end 

    context 'too short' do
      before { @location.country = 'a' }
      it { should_not be_valid }
    end 

    context 'too long' do
      before { @location.country = 'a'*101 }
      it { should_not be_valid }
    end 

    context 'not unique' do
      before { Location.make!(:country => @location.country) }
      it { should_not be_valid }
    end
  end

  # Invalid region
  context 'when :region is' do
    context 'too short' do
      before { @location.region = 'a' }
      it { should_not be_valid }
    end 

    context 'too long' do
      before { @location.region = 'a'*101 }
      it { should_not be_valid }
    end 
  end

  # Invalid city
  context 'when :city is' do
    context 'not present' do
      before { @location.city = nil }
      it { should_not be_valid }
    end 

    context 'too short' do
      before { @location.city = 'a' }
      it { should_not be_valid }
    end 

    context 'too long' do
      before { @location.city = 'a'*101 }
      it { should_not be_valid }
    end 
  end

end
