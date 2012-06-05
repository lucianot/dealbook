require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'manage marekts' do
  
  context 'moderator' do

    scenario 'can create new market' do
      market = Market.make
      login_mod
      click_link 'Markets'
      click_link 'New Market'
      fill_in 'Name', :with => market.name
      expect do
        click_button 'Submit'
      end.to change {Market.count}.by(1)
      page.should have_content 'Market was successfully created.'
      page.should have_content market.name
    end

    scenario 'can edit markets' do
      market = Market.make!
      login_mod
      click_link 'Markets'
      click_link 'Edit'
      fill_in 'Name', :with => 'mobile'
      click_button 'Submit'
      page.should have_content 'Market was successfully updated.'  
      page.should have_content 'mobile'      
    end

    scenario 'can delete markets' do
      market = Market.make!
      login_mod
      click_link 'Markets'
      expect do      
        click_link 'Destroy'
      end.to change {Market.count}.by(-1)
      page.should have_content 'Market was successfully deleted.'
      page.should_not have_content market.name      
    end

  end # context mod

  context 'admin' do

    scenario 'can create new market' do
      market = Market.make
      login_admin
      click_link 'Markets'
      click_link 'New Market'
      fill_in 'Name', :with => market.name
      expect do
        click_button 'Submit'
      end.to change {Market.count}.by(1)
      page.should have_content 'Market was successfully created.'
      page.should have_content market.name
    end

    scenario 'can edit markets' do
      market = Market.make!
      login_admin
      click_link 'Markets'
      click_link 'Edit'
      fill_in 'Name', :with => 'mobile'
      click_button 'Submit'
      page.should have_content 'Market was successfully updated.'  
      page.should have_content 'mobile'      
    end

    scenario 'can delete markets' do
      market = Market.make!
      login_admin
      click_link 'Markets'
      expect do      
        click_link 'Destroy'
      end.to change {Market.count}.by(-1)
      page.should have_content 'Market was successfully deleted.'
      page.should_not have_content market.name      
    end

  end

end 