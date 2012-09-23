require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'signup with linkedin' do

  scenario 'valid' do
		user = User.make
    visit "/"
    click_link 'Join Now'
    click_link 'Sign Up with Linkedin'
  	fill_in 'Full name', with: user.full_name
  	fill_in 'Email', with: user.email
  	fill_in 'Password', with: user.password
  	fill_in 'Password confirmation', with: user.password
  	click_button 'Sign up'
		page.should have_content "Welcome! You have signed up successfully"
  end

  scenario 'invalid'
end



