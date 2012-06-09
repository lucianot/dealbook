require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display deals' do
  
  context 'unauthenticated user' do

    scenario 'no deals' do
      visit '/'
      click_link 'Deals'
      page.should have_content 'No deals yet'
    end
    
    scenario 'one or more deals' do
      deal = Deal.make!(:full)
      visit '/'
      click_link 'Deals'
      page.should have_content deal.close_date
      page.should have_content deal.summary
      page.should_not have_content 'No deals yet'
    end

    scenario 'show deal' do
      deal = Deal.make!(:full)
      visit '/'
      click_link 'Deals'
      click_link deal.summary
      page.should have_content deal.close_date
      page.should have_content deal.company_name
      page.should have_content deal.investor_name
      page.should have_content deal.category
      page.should have_content deal.round        
      page.should_not have_link 'Edit'
      page.should have_link 'Back'
    end

  end
end