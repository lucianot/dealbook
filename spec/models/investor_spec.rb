require 'spec_helper'

describe Investor do
  before(:each) { @investor = Investor.make }
  subject { @investor }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Validations
  context 'validations' do
    before { Investor.make!(:name => @investor.name) }
    it { should have_valid(:name).when('a'*2, 'a'*100) }
    it { should_not have_valid(:name).when('a', 'a'*101,'',  nil) }
    it { should validate_uniqueness_of(:name) }

    it { should have_valid(:description).when('some_description', '', nil) }
    it { should_not have_valid(:description).when('a'*601) }

    it { should have_valid(:website).when('http://techcrunch.com', '', nil) }
    it { should_not have_valid(:website).when('http://invalid') }

    it { should have_valid(:linkedin).when('http://www.linkedin.com/company/' + rand(100_000).to_s, '', nil) }
    it { should_not have_valid(:linkedin).when('http://invalid') }

    it { should have_valid(:status).when('active', nil) }
    it { should_not have_valid(:status).when('invalid', '') }

    it { should have_valid(:category).when('VC', nil) }
    it { should_not have_valid(:category).when('invalid', '') }

    it { should have_valid(:stage).when(['Series A'], [''], nil) }
    it { should_not have_valid(:stage).when(['invalid']) }

  end

  # Associations
  context 'associations' do
    it { should have_and_belong_to_many(:markets) }
    it { should have_and_belong_to_many(:locations) }
    it { have_and_belong_to_many(:deals) }   
    it { should have_many(:companies).through(:deals) } 
  end 


  # # Invalid name
  # context 'when :name is' do

  #   context 'not present' do
  #     before { @investor.name = nil }
  #     it { should_not be_valid }
  #   end 

  #   context 'too short' do
  #     before { @investor.name = 'a' }
  #     it { should_not be_valid }
  #   end 

  #   context 'too long' do
  #     before { @investor.name = 'a'*101 }
  #     it { should_not be_valid }
  #   end 

  #   context 'not unique' do
  #     before { Investor.make!(:name => @investor.name) }
  #     it { should_not be_valid }
  #   end

  # end

  # # Invalid description
  # context 'when :description is too long' do 
  #   before { @investor.description = 'a'*601 }
  #   it { should_not be_valid }
  # end

  # # Invalid website
  # context 'when :url has wrong format' do
  #   before { @investor.website = 'invalid url'}
  #   it { should_not be_valid }
  # end

  # # Invalid linkedin
  # context 'when :linkedin has wrong format' do
  #   before { @investor.linkedin = 'invalid linkedin' }
  #   it { should_not be_valid }
  # end

  # #Invalid status
  # context 'when :status is' do
  #   context 'nil' do
  #     before { @investor.status = nil }
  #     it { should be_valid }
  #   end

  #   context 'not included in list' do
  #     before { @investor.status = 'invalid status' }
  #     it { should_not be_valid }
  #   end
  # end

  # #Invalid category
  # context 'when :category is' do
  #   context 'nil' do
  #     before { @investor.category = nil }
  #     it { should be_valid }
  #   end

  #   context 'not included in list' do
  #     before { @investor.category = 'invalid category' }
  #     it { should_not be_valid }
  #   end
  # end

  # #Invalid stage
  # context 'when :stage is' do
  #   context 'nil' do
  #     before { @investor.stage = nil }
  #     it { should be_valid }
  #   end

  #   context 'not included in list' do
  #     before { @investor.stage = [ 'invalid stage', 'another invalid stage' ] }
  #     it { should_not be_valid }
  #   end
  # end

  # # Has many markets
  # context 'when it has many markets' do
  #   before { @complete_investor = Investor.make!(:complete) }

  #   it 'should return array of markets' do
  #     @complete_investor.markets.count.should == 3
  #   end

  #   it 'should be included in each market' do
  #     @complete_investor.markets.each do |market|
  #       market.investors.include?(@complete_investor).should be_true
  #     end
  #   end
  # end

  # # Has many locations
  # context 'when it has many locations' do
  #   before { @complete_investor = Investor.make!(:complete) }

  #   it 'should return array of locations' do
  #     @complete_investor.locations.count.should == 3
  #   end
    
  #   it 'should be included in each market' do
  #     @complete_investor.locations.each do |location|
  #       location.investors.include?(@complete_investor).should be_true
  #     end
  #   end
  # end

end




