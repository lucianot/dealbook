require 'spec_helper'

describe Deal do
  before(:each) { @deal = Deal.make! }
  subject { @deal }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Validations
  context 'validations' do
    it { should have_valid(:deal_date).when(Date.today) }
    it { should_not have_valid(:deal_date).when('a', nil) }

    it { should have_valid(:category).when('financing round') }
    it { should_not have_valid(:category).when('invalid', '', nil) } 

    it { should have_valid(:round).when('Series A') }
    it { should_not have_valid(:round).when('invalid', '', nil) }

    it { should have_valid(:amount).when(1_000_000, nil) }
    it { should_not have_valid(:amount).when(-1, 42.0) }  # TODO: test blank

    it { should have_valid(:pre_valuation).when(10_000_000, nil) }
    it { should_not have_valid(:pre_valuation).when(-1, 42.0) }  # TODO: test blank

    it { should have_valid(:source_url).when('http://techcrunch.com', '', nil) }
    it { should_not have_valid(:source_url).when('http://invalid') }

    # it { should_not have_valid(:company_id).when(nil) }    
  end

  # Associations
  context 'associations' do
    it { should belong_to(:company) }
    it { should have_and_belong_to_many(:investors) }
  end


  # # Invalid category
  # context 'when :category is' do
  #   context 'not present' do
  #     before { @deal.category = nil }
  #     it { should_not be_valid }
  #   end 

  #   context 'not included in list' do
  #     before { @deal.category = 'invalid_category' }
  #     it { should_not be_valid }
  #   end
  # end

  # # Invalid round
  # context 'when :round is' do

  #   context 'not present' do
  #     before { @deal.round = nil }
  #     it { should_not be_valid }
  #   end 

  #   context 'not included in list' do
  #     before { @deal.round = 'invalid_round' }
  #     it { should_not be_valid }
  #   end
  # end 

  # # Invalid amount
  # context 'when :amount is' do
  #   context 'nil' do
  #     before { @deal.amount = nil }
  #     it { should be_valid }
  #   end

  #   context 'not a number' do
  #     before { @deal.amount = 'a'}
  #     it { should_not be_valid }
  #   end 

  #   context 'not an integer' do
  #     before { @deal.amount = 42.0 }
  #   it { should_not be_valid }
  #   end 
  # end

  # # Invalid pre_valuation
  # context 'when :pre_valuation is' do
  #   context 'nil' do
  #     before { @deal.pre_valuation = nil }
  #     it { should be_valid }
  #   end

  #   context 'not a number' do
  #     before { @deal.pre_valuation = 'a'}
  #     it { should_not be_valid }
  #   end 

  #   context 'not an integer' do
  #     before { @deal.pre_valuation = 42.0 }
  #   it { should_not be_valid }
  #   end 
  # end

  # # Invalid source url
  # context 'when :source_url is' do
  #   context 'nil' do
  #     before { @deal.source_url = nil }
  #     it { should be_valid }
  #   end

  #   context 'in wrong format' do
  #     before { @deal.source_url = 'invalid_url'}
  #     it { should_not be_valid }
  #   end 
  # end

  # # Belongs to company
  # context 'when it belongs to company' do
  #   before { @another_deal = Deal.make! }

  #   it 'should return company' do
  #     @another_deal.company should be_true
  #   end

  #   it 'should be included in company' do
  #     @another_deal.company.deals.include?(@another_deal).should be_true
  #   end
  # end

  # # Belongs to investor
  # context 'when it belongs to investor' do
  #   before { @another_deal = Deal.make! }

  #   it 'should return investor' do
  #     @another_deal.investor should be_true
  #   end

  #   it 'should be included in investor' do
  #     @another_deal.investor.deals.include?(@another_deal).should be_true
  #   end
  # end

end











