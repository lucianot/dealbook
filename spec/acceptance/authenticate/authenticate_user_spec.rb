require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'authenticate' do

  context 'sign up' do
    scenario 'valid' do
      sign_up_new_user 
      page.should have_content "Welcome! You have signed up successfully"
    end
 
    scenario 'invalid' do
      visit "/"
      click_link 'Join Now'
      click_link 'Sign Up with Email'
      click_button 'Sign up'
      page.should have_content "Please review the problems below"
    end
  end

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
      click_link 'Logout'
      page.should have_content "The ultimate resource for tech deals in Brazil"
    end
  end
end



