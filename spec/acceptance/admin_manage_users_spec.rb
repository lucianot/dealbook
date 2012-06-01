require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'admin manage users' do
  
  context 'login' do
    scenario 'valid' do
      admin = User.make!
      admin.add_role :admin
      login(admin)
      admin.has_role?(:admin).should be_true
      page.should have_link 'Admin'
    end

    scenario 'invalid' do
      user = User.make!
      login(user)
      user.has_role?(:admin).should be_false
      page.should_not have_link 'Admin'
    end
  end

end