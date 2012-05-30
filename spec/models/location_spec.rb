require 'spec_helper'

describe Location do
  before(:each) { @location = Location.make }
  subject { @location }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

# Validations
  context 'validations' do
    it { should have_valid(:country).when('a'*2, 'a'*100) }
    it { should_not have_valid(:country).when('a', 'a'*101, nil) }

    it { should have_valid(:region).when('a'*2, 'a'*100) }
    it { should_not have_valid(:region).when('a', 'a'*101, nil) }

    it { should have_valid(:city).when('a'*2, 'a'*100) }
    it { should_not have_valid(:city).when('a', 'a'*101, nil) }    

    # Uniqueness of country + region + city
    context 'when location attributes are' do
      context 'not unique (only two)' do
        before { Location.make!( :country => @location.country,
                                 :city => @location.city ) }
        it { should be_valid }
      end

      context 'not unique (all three)' do
        before { Location.make!( :country => @location.country,
                                 :region => @location.region,
                                 :city => @location.city ) }
        it { should_not be_valid }
      end
    end    
  end

  # Associations
  context 'associations' do
    it { should have_and_belong_to_many(:companies) }    
    it { should have_and_belong_to_many(:investors) }        
  end 


  # # Invalid country
  # context 'when :country is' do
  #   context 'not present' do
  #     before { @location.country = nil }
  #     it { should_not be_valid }
  #   end 

  #   context 'too short' do
  #     before { @location.country = 'a' }
  #     it { should_not be_valid }
  #   end 

  #   context 'too long' do
  #     before { @location.country = 'a'*101 }
  #     it { should_not be_valid }
  #   end 
  # end

  # # Invalid region
  # context 'when :region is' do
  #   context 'not present' do
  #     before { @location.region = nil }
  #     it { should_not be_valid }
  #   end 

  #   context 'too short' do
  #     before { @location.region = 'a' }
  #     it { should_not be_valid }
  #   end 

  #   context 'too long' do
  #     before { @location.region = 'a'*101 }
  #     it { should_not be_valid }
  #   end 
  # end

  # # Invalid city
  # context 'when :city is' do
  #   context 'not present' do
  #     before { @location.city = nil }
  #     it { should_not be_valid }
  #   end 

  #   context 'too short' do
  #     before { @location.city = 'a' }
  #     it { should_not be_valid }
  #   end 

  #   context 'too long' do
  #     before { @location.city = 'a'*101 }
  #     it { should_not be_valid }
  #   end 
  # end

  # # Has many companies
  # context 'when it has many companies' do
  #   before { @complete_location = Location.make!(:complete) }

  #   it 'should return array of companies' do
  #     @complete_location.companies.count.should == 3
  #   end

  #   it 'should be included in each company' do
  #     @complete_location.companies.each do |company|
  #       company.locations.include?(@complete_location).should be_true
  #     end
  #   end
  # end

  # # Has many investors
  # context 'when it has many investors' do
  #   before { @complete_location = Location.make!(:complete) }

  #   it 'should return array of investors' do
  #     @complete_location.investors.count.should == 2
  #   end
    
  #   it 'should be included in each investor' do
  #     @complete_location.investors.each do |investor|
  #       investor.locations.include?(@complete_location).should be_true
  #     end
  #   end
  # end

end







