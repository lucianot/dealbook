require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display companies' do

  context 'guest' do

    scenario 'no companies' do
      visit '/'
      find('#companies_button').click
      page.should have_content 'No companies yet'
    end

    scenario 'one or more companies' do
      company = Company.make!
      visit '/'
      find('#companies_button').click
      page.should have_content company.name
      page.should_not have_content 'No companies yet'
    end

    scenario 'show company' do
      company = Company.make!
      visit '/'
      find('#companies_button').click
      click_link company.name
      page.should have_content company.name
      page.should have_content company.description
      page.should have_content company.website
      page.should have_content company.linkedin
      page.should have_content company.status
      #TODO: include markets, locations
      page.should_not have_link 'Add new deal'
      page.should_not have_link 'Edit'
      page.should_not have_link 'Destroy'
      page.should have_link 'Back'
    end
  end

  context 'user' do
    scenario 'show company' do
      company = Company.make!
      login_normal
      find('#companies_button').click
      click_link company.name
      page.should have_content company.name
      page.should have_content company.description
      page.should have_content company.website
      page.should have_content company.linkedin
      page.should have_content company.status          
      #TODO: include markets, locations
      page.should have_link 'Add new deal'
      page.should have_link 'Edit'
      page.should have_link 'Destroy'
      page.should have_link 'Back'
    end

    scenario 'add new deal for company' do
      company = Company.make!
      login_normal
      find('#companies_button').click
      click_link company.name
      page.should have_content company.name    
      page.should have_link 'Add new deal'
      click_link 'Add new deal'
      page.should have_content 'Create new deal'
      uri = URI.parse(current_url)
      uri.path.should == "/deals/new"
      page.has_select?('Company', :selected => company.name).should be_true    
    end
  end
end



