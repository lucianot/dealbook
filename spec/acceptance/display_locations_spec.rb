require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display locations' do

  context 'authenticated user' do
    scenario 'cannot access locations' do
      visit '/'
      page.should_not have_link 'Locations'
    end
  end

  context 'normal user' do
    scenario 'cannot access locations' do
      normal = login_normal
      page.should_not have_link 'Locations'
    end
  end

  context 'moderator' do

    scenario 'no locations' do
      login_mod
      click_link 'Locations'
      page.should have_content 'No locations yet'
    end

    scenario 'one or more locations' do
      location = Location.make!
      login_mod
      click_link 'Locations'
      page.should have_content location.country
      page.should have_content location.region
      page.should have_content location.city
      page.should_not have_content 'No locations yet'
    end

  end
end
