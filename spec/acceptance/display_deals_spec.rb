require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display deals' do
  
  context 'unauthenticated user' do

    scenario 'no deals' do
      visit '/'
      click_link 'Deals'
      page.should have_content 'No deals yet'
    end
    
    scenario 'one or more deals' do
      deal = Deal.make!
      visit '/'
      click_link 'Deals'
      page.should have_content deal.deal_date
      page.should have_content deal.summary
      page.should_not have_content 'No deals yet'
    end

    # scenario 'show deal' do
    #   deal = Deal.make!
    #   visit '/'
    #   click_link 'Deals'
    #   click_link company.name
    #   page.should have_content company.name
    #   page.should have_content company.description
    #   page.should have_content company.website
    #   page.should have_content company.linkedin
    #   page.should have_content company.status          
    #   #TODO: include markets, locations
    #   page.should_not have_link 'Edit'
    #   page.should have_link 'Back'
    # end

  end
end