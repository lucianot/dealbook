require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'manage deals' do

  context 'unauthenticated user' do

    scenario 'cannot manage deals' do
      visit '/'
      find('#deals_button').click
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
      click_button 'New Deal'
      find('#deal_close_date_1i').select '2012'
      find('#deal_close_date_2i').select 'June'
      find('#deal_close_date_3i').select '10'
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
      page.should have_link company.name
      page.should have_content 'Unverified'
      uri = URI.parse(current_url)
      uri.path.should == "/deals/#{Deal.first.id}"
    end

    scenario 'can edit deals' do
      deal = Deal.make!(:complete)
      new_round = 'Series A'
      login_normal
      click_link 'Deals'
      click_button "edit_#{deal.id}"
      select new_round, :from => 'Round'
      expect do
        click_button 'Update Deal'
      end.to change {Deal.count}.by(0)
      page.should have_content 'Deal was successfully updated.'
      page.should have_content new_round
      page.should have_content 'Unverified'
      uri = URI.parse(current_url)
      uri.path.should == "/deals/#{deal.id}"      

    end

    scenario 'can delete deals' do
      deal = Deal.make!(:complete)
      login_normal
      click_link 'Deals'
      expect do
        click_button "destroy_#{deal.id}"
      end.to change {Deal.count}.by(-1)
      page.should have_content 'Deal was successfully deleted.'
      uri = URI.parse(current_url)
      uri.path.should == "/deals"      
    end

  end # context

end # feature
