require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'link account to linkedin' do
  before do 
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      :provider => 'linkedin',
      :uid => '12345',
      :info => { :name => 'user', :email => "user@example.com" }
    })
  end
  scenario 'valid linkedin credentials'
  scenario 'valid' do
    user = User.make!
    login(user)
    visit "/users/edit"
    click_link 'Associate a Linkedin account'
    page.should have_content "Sucessfully logged in with Linkedin!"
    
  end
  #   
  #   # Insert credentials?
  #   page.should have_content "Success! Your Linkedin account is linked."
  #   
  # end 

  scenario 'invalid linkedin credentials'
  #   login_normal
  #   visit "/users/edit"
  #   click_link 'Link to your Linkedin account'
  #   # Insert credentials?
  #   page.should have_content "Invalid Linkedin account"
  #   page.should have_content "Link to your Linkedin account"
  # end 
end


