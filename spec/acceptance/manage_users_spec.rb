require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'manage users' do

  context 'admins' do

    scenario 'edit user role' do
      user = User.make!
      admin = login_admin
      click_link user.full_name
      click_link 'Manage users'
      click_button "edit_#{user.id}"
      select 'Moderator', :from => 'Role'
      click_button 'Update User'
      page.should have_content 'User was successfully updated.'
      page.should have_content 'moderator'
    end
  end

  context 'mods' do

    scenario 'see users, but cannot edit' do
      user = User.make!
      mod = login_mod
      click_link user.full_name
      click_link 'Manage users'
      page.should have_link user.full_name
      page.should_not have_link "edit_#{user.id}"
    end
  end

  context 'users and guests' do

    scenario 'cannot access users' do
      normal = login_normal
      normal.role.should_not == 'admin'
      page.should_not have_link 'Admin'
    end
  end

end
