require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'manage users' do
  
  context 'logged as admin' do

    scenario 'edit user role' do
      user = User.make!
      admin = login_admin
      click_link 'Admin'
      click_link 'Edit'
      page.should have_content 'Users#edit'
      page.should have_field 'Full name', :with => user.full_name
      page.should have_field 'Role', :with => 'normal'
      select 'Moderator', :from => 'Role'
      page.should have_field 'Role', :with => 'moderator'
      expect {click_button 'Submit'}.to change {user.role}.to('moderator')
      page.should have_content 'User was successfully updated.'      
    end
  end

  context 'logged as normal' do

    scenario 'cannot access users' do
      normal = login_normal
      normal.role.should_not == 'admin'
      page.should_not have_link 'Admin'
    end    
  end 

end 




