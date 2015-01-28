require 'spec_helper'

describe Dealing do
  subject { @dealing }

  before { @dealing = Dealing.make(:investor) }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Validations
  # Uniqueness of deal, buyer, buyer_type
  context 'when location attributes are' do
    context 'not unique (only two)' do
      before { Dealing.make!( :deal_id => @dealing.deal_id,
                              :buyer_id => 2,
                              :buyer_type => @dealing.buyer_type ) }
      it { should be_valid }
    end

    context 'not unique (all three)' do
      before { Dealing.make!( :deal_id => @dealing.deal_id,
                              :buyer_id => @dealing.buyer_id,
                              :buyer_type => @dealing.buyer_type ) }
      it { should_not be_valid }
    end
  end

  # Associations
  context 'associations' do
    it { should belong_to(:deal) }
    it { should belong_to(:buyer) }
    it { should belong_to(:investor) }
    it { should belong_to(:corporate) }
  end

end
