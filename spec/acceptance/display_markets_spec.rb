require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display markets' do

  context 'authenticated user' do
    scenario 'cannot access markets' do
      visit '/'
      page.should_not have_link 'Markets'
    end    
  end
  
  context 'normal user' do
    scenario 'cannot access markets' do
      normal = login_normal
      page.should_not have_link 'Markets'
    end    
  end

  context 'moderator' do

    scenario 'no markets' do
      login_mod
      click_link 'Markets'
      page.should have_content 'No markets yet'
    end
    
    scenario 'one or more markets' do
      market = Market.make!
      login_mod
      click_link 'Markets'
      page.should have_content market.name
      page.should_not have_content 'No markets yet'
    end

  end
end