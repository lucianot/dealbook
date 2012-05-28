require 'spec_helper'

describe Investor do
  before(:each) { @investor = Investor.make }
  subject { @investor }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end
 
  # Invalid name
  context 'when :name is' do

    context 'not present' do
      before { @investor.name = nil }
      it { should_not be_valid }
    end 

    context 'too short' do
      before { @investor.name = 'a' }
      it { should_not be_valid }
    end 

    context 'too long' do
      before { @investor.name = 'a'*101 }
      it { should_not be_valid }
    end 

    context 'not unique' do
      before { Investor.make!(:name => @investor.name) }
      it { should_not be_valid }
    end

  end

  # Invalid description
  context 'when :description is too long' do 
    before { @investor.description = 'a'*601 }
    it { should_not be_valid }
  end

  # Invalid website
  # TODO: insert other test case (with Valid Attributes?)
  # TODO: store http?
  context 'when :url has wrong format' do
    before { @investor.website = 'invalid url'}
    it { should_not be_valid }
  end

  # Invalid linkedin
  # TODO: insert other test case (with Valid Attributes?)
  # TODO: store http?
  context 'when :linkedin has wrong format' do
    before { @investor.linkedin = 'invalid linkedin' }
    it { should_not be_valid }
  end

  #Invalid status
  context 'when :status is' do
    context 'nil' do
      before { @investor.status = nil }
      it { should be_valid }
    end

    context 'not included in list' do
      before { @investor.status = 'invalid status' }
      it { should_not be_valid }
    end
  end

  #Invalid category
  context 'when :category is' do
    context 'nil' do
      before { @investor.category = nil }
      it { should be_valid }
    end

    context 'not included in list' do
      before { @investor.category = 'invalid category' }
      it { should_not be_valid }
    end
  end

  #Invalid stage
  context 'when :stage is'do
    context 'nil' do
      before { @investor.stage = nil }
      it { should be_valid }
    end
  
    context 'not included in list' do
      before { @investor.stage = [ 'invalid stage', 'another invalid stage' ] }
      it { should_not be_valid }
    end
  end
end





