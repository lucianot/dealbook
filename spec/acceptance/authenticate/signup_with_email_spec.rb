require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'signup with email' do
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
end



