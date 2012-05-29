require 'spec_helper'

describe Company do
  before(:each) { @company = Company.make }
  subject { @company }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Validations
  context 'validations' do
    before { Company.make!(:name => @company.name) }
    it { should have_valid(:name).when('a'*2, 'a'*100) }
    it { should_not have_valid(:name).when('a', 'a'*101, nil) }
    it { should validate_uniqueness_of(:name) }

    it { should have_valid(:description).when('some_description', nil) }
    it { should_not have_valid(:description).when('a'*601) }

    it { should have_valid(:website).when('http://techcrunch.com', nil) }
    it { should_not have_valid(:website).when('http://invalid') }

    it { should have_valid(:linkedin).when('http://www.linkedin.com/company/' + rand(100_000).to_s, nil) }
    it { should_not have_valid(:linkedin).when('http://invalid') }

    it { should have_valid(:status).when('acquired', 'active', nil) }
    it { should_not have_valid(:status).when('invalid', '') }
  end

  # Associations
  context 'associations' do
    it { should have_and_belong_to_many(:markets) }
    it { should have_and_belong_to_many(:locations) }
    it { should have_many(:deals) }    
  end


  # # Invalid name
  # context 'when :name is' do

  #   context 'not present' do
  #     before { @company.name = nil }
  #     it { should_not be_valid }
  #   end 

  #   context 'too short' do
  #     before { @company.name = 'a' }
  #     it { should_not be_valid }
  #   end 

  #   context 'too long' do
  #     before { @company.name = 'a'*101 }
  #     it { should_not be_valid }
  #   end 

  #   context 'not unique' do
  #     before { Company.make!(:name => @company.name) }
  #     it { should_not be_valid }
  #   end
  # end

  # # Invalid description
  # context 'when :description is too long' do 
  #   before { @company.description = 'a'*601 }
  #   it { should_not be_valid }
  # end

  # # Invalid website
  # context 'when :url has wrong format' do
  #   before { @company.website = 'invalid_url'}
  #   it { should_not be_valid }
  # end

  # # Invalid linkedin
  # context 'when :linkedin has wrong format' do
  #   before { @company.linkedin = 'invalid_linkedin' }
  #   it { should_not be_valid }
  # end

  # # Invalid status
  # context 'when :status is' do
  #   context 'nil' do
  #     before { @company.status = nil }
  #     it { should be_valid }
  #   end

  #   context 'not included in list' do
  #     before { @company.status = 'invalid_status' }
  #     it { should_not be_valid }
  #   end
  # end

  # # Has many markets
  # context 'when it has many markets' do
  #   before { @complete_company = Company.make!(:complete) }

  #   it 'should return array of markets' do
  #     @complete_company.markets.count.should == 2
  #   end

  #   it 'should be included in each market' do
  #     @complete_company.markets.each do |market|
  #       market.companies.include?(@complete_company).should be_true
  #     end
  #   end
  # end

  # # Has many locations
  # context 'when it has many locations' do
  #   before { @complete_company = Company.make!(:complete) }

  #   it 'should return array of locations' do
  #     @complete_company.locations.count.should == 2
  #   end
    
  #   it 'should be included in each location' do
  #     @complete_company.locations.each do |location|
  #       location.companies.include?(@complete_company).should be_true
  #     end
  #   end
  # end
end


























