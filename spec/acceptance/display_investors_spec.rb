require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display investors' do
  
  context 'unauthenticated user' do

    scenario 'no investors' do
      visit '/'
      click_link 'Investors'
      page.should have_content 'No investors yet'
    end
    
    scenario 'one or more investors' do
      investor = Investor.make!
      visit '/'
      click_link 'Investors'
      page.should have_content investor.name
      page.should_not have_content 'No investors yet'
    end

    scenario 'show investor' do
      investor = Investor.make!
      visit '/'
      click_link 'Investors'
      click_link investor.name           # TODO: change link to investor name
      page.should have_content investor.name
      page.should have_content investor.description
      page.should have_content investor.website
      page.should have_content investor.linkedin
      page.should have_content investor.category
      page.should have_content investor.status                  
      #TODO: include markets, locations
      page.should_not have_link 'Edit'
      page.should have_link 'Back'
    end

  end
end