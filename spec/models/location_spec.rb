require 'spec_helper'

describe Location do
  subject { @location }

  before { @location = Location.make }

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
        before { Location.make!( country: @location.country,
                                 region: 'unique region',
                                 city: @location.city, ) }
        it { should be_valid }
      end

      context 'not unique (all three)' do
        before { Location.make!( country: @location.country,
                                 region: @location.region,
                                 city: @location.city ) }
        it { should_not be_valid }
      end
    end
  end

  # Associations
  context 'associations' do
    it { should have_and_belong_to_many(:companies) }    
    it { should have_and_belong_to_many(:investors) }        
  end 

  # Methods
  context '#full' do
    it { @location.full.should == "#{@location.city}, #{@location.region}, #{@location.country}"}
  end

end
