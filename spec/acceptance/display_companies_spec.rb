require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display companies' do
  
  context 'unauthenticated user' do

    scenario 'no companies' do
      visit '/'
      click_link 'Companies'
      page.should have_content 'No companies yet'
    end
    
    scenario 'one or more companies' do
      company = Company.make!
      visit '/'
      click_link 'Companies'
      page.should have_content company.name
      page.should_not have_content 'No companies yet'
    end

    scenario 'show company' do
      company = Company.make!
      visit '/'
      click_link 'Companies'
      click_link company.name             # TODO: change link to company name
      page.should have_content company.name
      page.should have_content company.description
      page.should have_content company.website
      page.should have_content company.linkedin
      page.should have_content company.status          
      #TODO: include markets, locations
      page.should_not have_link 'Edit'
      page.should have_link 'Back'
    end

  end
end
