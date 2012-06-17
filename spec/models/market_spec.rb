require 'spec_helper'

describe Market do
  before { @market = Market.make }
  subject { @market }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

# Validations
  context 'validations' do
    it { should have_valid(:name).when('a'*2, 'a'*100) }
    it { should_not have_valid(:name).when('a', 'a'*101, nil) }
  end

  # Associations
  context 'associations' do
    it { should have_and_belong_to_many(:companies) }    
    it { should have_and_belong_to_many(:investors) }        
  end 

  
  # # Invalid name
  # context 'when :name is' do

  #   context 'not present' do
  #     before { @market.name = nil }
  #     it { should_not be_valid }
  #   end 

  #   context 'too short' do
  #     before { @market.name = 'a' }
  #     it { should_not be_valid }
  #   end 

  #   context 'too long' do
  #     before { @market.name = 'a'*101 }
  #     it { should_not be_valid }
  #   end 

  #   context 'not unique' do
  #     before { Market.make!(:name => @market.name) }
  #     it { should_not be_valid }
  #   end
  # end

  # # Has many companies
  # context 'when it has many companies' do
  #   before { @complete_market = Market.make!(:complete) }

  #   it 'should return array of companies' do
  #     @complete_market.companies.count.should == 2
  #   end

  #   it 'should be included in each company' do
  #     @complete_market.companies.each do |company|
  #       company.markets.include?(@complete_market).should be_true
  #     end
  #   end
  # end

  # # Has many investors
  # context 'when it has many investors' do
  #   before { @complete_market = Market.make!(:complete) }

  #   it 'should return array of investors' do
  #     @complete_market.investors.count.should == 3
  #   end
    
  #   it 'should be included in each investor' do
  #     @complete_market.investors.each do |investor|
  #       investor.markets.include?(@complete_market).should be_true
  #     end
  #   end
  # end

end



