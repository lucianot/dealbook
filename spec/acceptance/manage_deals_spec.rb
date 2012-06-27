require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'manage deals' do

  context 'unauthenticated user' do

    scenario 'cannot manage deals' do
      visit '/'
      click_link 'Deals'
      page.should_not have_link 'New deal'
      page.should_not have_link 'Edit'
      page.should_not have_link 'Destroy'
    end

  end # context

  context 'regular user' do

    scenario 'can create new deal' do
      deal = Deal.make
      company = Company.make!
      investor = Investor.make!
      login_normal
      click_link 'Deals'
      click_button 'New deal'
      select '2012', :from => 'Close date'
      select '12', :from => 'Close date'
      select '20', :from => 'Close date'
      select company.name, :from => 'Company'
      select deal.category, :from => 'Category'
      select deal.round, :from => 'Round'
      select investor.name, :from => 'deal_offerings_buyers'
      select deal.currency, :from => 'Currency'
      fill_in 'Amount', :with => deal.amount
      fill_in 'Pre-money Valuation', :with => deal.pre_valuation
      fill_in 'Source', :with => deal.source_url
      expect do
        click_button 'Create Deal'
      end.to change {Deal.count}.by(1)
      page.should have_content 'Deal was successfully created.'
      page.should have_content company.name
      click_link Deal.find_by_company_id(company).id.to_s
      page.should have_link company.name
      page.should have_content investor.name
    end

    scenario 'can edit deals' do
      deal = Deal.make!(:complete)
      new_round = 'Series A'
      login_normal
      click_link 'Deals'
      click_link 'Edit'
      select new_round, :from => 'Round'
      expect do
        click_button 'Update Deal'
      end.to change {Deal.count}.by(0)
      page.should have_content 'Deal was successfully updated.'
      click_link deal.id.to_s
      page.should have_content new_round
    end

    scenario 'can delete deals' do
      deal = Deal.make!(:complete)
      login_normal
      click_link 'Deals'
      expect do
        click_link 'Destroy'
      end.to change {Deal.count}.by(-1)
      page.should have_content 'Deal was successfully deleted.'
      page.should_not have_content deal.summary
    end

  end # context

end # feature
