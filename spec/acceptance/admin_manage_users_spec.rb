require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'admin manage users' do
  
  context 'login' do
    scenario 'valid' do
      admin = login_admin
      admin.role.should == 'admin'
      page.should have_link 'Admin'
    end

    scenario 'invalid' do
      user = login_normal
      user.role.should_not == 'admin'
      page.should_not have_link 'Admin'
    end

  end # context

end # feature