require 'spec_helper'

describe Dealing do
  before(:each) { @dealing = Dealing.make!(:investor) }
  subject { @dealing }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid } 
  end

  # Validations
  # TODO: validates uniqueness of dealing
  # # Uniqueness of deal, buyer, buyer_type
  # context 'when location attributes are' do
  #   context 'not unique (only two)' do
  #     before { Dealing.make!( :deal_id => @dealing.deal_id,
  #                             :buyer_id => @dealing.buyer_id+1,
  #                             :buyer_type => @dealing.buyer_type ) }
  #     it { should be_valid }
  #   end

  #   context 'not unique (all three)' do
  #     before { Dealing.make!( :deal_id => @dealing.deal_id,
  #                             :buyer_id => @dealing.buyer_id,
  #                             :buyer_type => @dealing.buyer_type ) }
  #     it { should_not be_valid }
  #   end
  # end    

  # Associations
  context 'associations' do
    it { should belong_to(:deal) }
    it { should belong_to(:buyer) }
    it { should belong_to(:investor) }   
    it { should belong_to(:corporate) } 
  end 

end