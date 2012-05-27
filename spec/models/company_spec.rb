require 'spec_helper'

describe Company do
  before(:each) { @company = Company.make }
  subject { @company }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end
 
  # Invalid name
  context 'when :name is' do

    context 'not present' do
      before { @company.name = nil }
      it { should_not be_valid }
    end 

    context 'too short' do
      before { @company.name = 'a' }
      it { should_not be_valid }
    end 

    context 'too long' do
      before { @company.name = 'a'*101 }
      it { should_not be_valid }
    end 

    context 'not unique' do
      before { Company.make!(:name => @company.name) }
      it { should_not be_valid }
    end

  end

  # Invalid description
  context 'when :description is too long' do 
    before { @company.description = 'a'*601 }
    it { should_not be_valid }
  end

  # Invalid website
  # TODO: insert other test case (with Valid Attributes?)
  # TODO: store http?
  context 'when :url has wrong format' do
    before { @company.website = 'invalid_url'}
    it { should_not be_valid }
  end

  # Invalid linkedin
  # TODO: insert other test case (with Valid Attributes?)
  # TODO: store http?
  context 'when :linkedin has wrong format' do
    before { @company.linkedin = 'invalid_linkedin' }
    it { should_not be_valid }
  end

  #Invalid status
  context 'when :status is not included in list' do
    before { @company.status = 'invalid_status' }
    it { should_not be_valid }
  end

end


























