require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'login with email' do

  context 'login' do
    scenario 'valid' do
      user = User.make!
      login(user)
      page.should have_content user.full_name
    end

    scenario 'invalid' do
      user = User.make
      login(user)
      page.should have_content "Invalid email or password"
    end
  end

  context 'logout' do
    scenario 'successful' do
      sign_up_new_user
      logout
      page.should have_content "The ultimate resource for tech deals in Brazil"
    end
  end
end
