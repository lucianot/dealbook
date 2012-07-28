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

end



