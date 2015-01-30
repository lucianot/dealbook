require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display investors' do

  context 'guest' do

    scenario 'no investors' do
      visit '/'
      find('#investors_button').click
      page.should have_content 'No investors yet'
    end

    scenario 'one or more investors' do
      investor = Investor.make!
      visit '/'
      find('#investors_button').click
      page.should have_content investor.name
      page.should_not have_content 'No investors yet'
    end

    scenario 'show investor' do
      investor = Investor.make!
      visit '/'
      find('#investors_button').click
      click_link investor.name
      page.should have_content investor.name
      page.should have_content investor.description
      page.should have_content investor.website
      page.should have_content investor.linkedin
      page.should have_content investor.category
      #TODO: include stages
      page.should have_content investor.status
      #TODO: include markets, locations
      page.should_not have_link 'Edit'
      page.should_not have_link 'Destroy'
      page.should have_link 'Back'
    end
  end

  context 'user' do
    scenario 'show investor' do
      investor = Investor.make!
      login_normal
      find('#investors_button').click
      click_link investor.name
      page.should have_content investor.name
      page.should have_content investor.description
      page.should have_content investor.website
      page.should have_content investor.linkedin
      page.should have_content investor.category
      #TODO: include stages
      page.should have_content investor.status                  
      #TODO: include markets, locations
      page.should have_link 'Edit'
      page.should have_link 'Destroy'         
      page.should have_link 'Back'
    end
  end

end
