require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'manage locations' do
  
  context 'moderator' do

    scenario 'can create new location' do
      location = Location.make
      login_mod
      click_link 'Locations'
      click_link 'New Location'
      select location.country, :from => 'Country'
      fill_in 'Region', :with => location.region
      fill_in 'City', :with => location.city        
      expect do
        click_button 'Create Location'
      end.to change {Location.count}.by(1)
      page.should have_content 'Location was successfully created.'
      page.should have_content location.country
      page.should have_content location.region
      page.should have_content location.city            
    end

    scenario 'can edit locations' do
      location = Location.make!
      other_location = Location.make
      login_mod
      click_link 'Locations'
      click_link 'Edit'
      select location.country, :from => 'Country'
      fill_in 'Region', :with => other_location.region
      fill_in 'City', :with => other_location.city           
      click_button 'Update Location'
      page.should have_content 'Location was successfully updated.'  
      page.should have_content other_location.country
      page.should have_content other_location.region     
      page.should have_content other_location.city  
    end

    scenario 'can delete locations' do
      location = Location.make!
      login_mod
      click_link 'Locations'
      expect do      
        click_link 'Destroy'
      end.to change {Location.count}.by(-1)
      page.should have_content 'Location was successfully deleted.'
      page.should_not have_content location.country      
    end

  end # context mod

  context 'admin' do

    scenario 'can create new location' do
      location = Location.make
      login_admin
      click_link 'Locations'
      click_link 'New Location'
      select location.country, :from => 'Country'
      fill_in 'Region', :with => location.region
      fill_in 'City', :with => location.city        
      expect do
        click_button 'Create Location'
      end.to change {Location.count}.by(1)
      page.should have_content 'Location was successfully created.'
      page.should have_content location.country
      page.should have_content location.region
      page.should have_content location.city            
    end

    scenario 'can edit locations' do
      location = Location.make!
      other_location = Location.make
      login_admin
      click_link 'Locations'
      click_link 'Edit'
      select location.country, :from => 'Country'
      fill_in 'Region', :with => other_location.region
      fill_in 'City', :with => other_location.city           
      click_button 'Update Location'
      page.should have_content 'Location was successfully updated.'  
      page.should have_content other_location.country
      page.should have_content other_location.region     
      page.should have_content other_location.city  
    end

    scenario 'can delete locations' do
      location = Location.make!
      login_admin
      click_link 'Locations'
      expect do      
        click_link 'Destroy'
      end.to change {Location.count}.by(-1)
      page.should have_content 'Location was successfully deleted.'
      page.should_not have_content location.country      
    end

  end # context admin  

end 