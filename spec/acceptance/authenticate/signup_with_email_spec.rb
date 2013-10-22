require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'signup with email' do
  context 'sign up' do
    scenario 'valid' do
      sign_up_new_user
      page.should have_content "Welcome! You have signed up successfully"
    end

    scenario 'invalid' do
      visit "/"
      find('#join_now_link').click
      click_link 'Sign up with Email'
      click_button 'Sign up'
      page.should have_content "Please review the problems below"
    end
  end
end



