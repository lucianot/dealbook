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
      click_link 'New deal'
      fill_in 'Close date', :with => deal.close_date
      select company.name, :from => 'Company'
      select investor.name, :from => 'Investors'
      select deal.category, :from => 'Category'
      select deal.round, :from => 'Round'      
      fill_in 'Amount', :with => deal.amount
      fill_in 'Pre-money Valuation', :with => deal.pre_valuation
      fill_in 'Source', :with => deal.source_url 
      expect do
        click_button 'Submit'
      end.to change {Deal.count}.by(1)
      page.should have_content 'Deal was successfully created.'
      page.should have_content deal.summary
      click_link deal.summary
      page.should have_content "Company: #{company.name}"
      page.should have_content "Investors: #{investor.name}"
    end

    scenario 'can edit deals' do
      deal = Deal.make!(:full)
      new_date = deal.close_date+1
      login_normal
      click_link 'Deals'
      click_link 'Edit'
      fill_in 'Close date', :with => new_date
      expect do
        click_button 'Submit'
      end.to change {Deal.count}.by(0)
      page.should have_content 'Deal was successfully updated.'
      page.should have_content new_date
    end

    scenario 'can delete deals' do
      deal = Deal.make!
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
