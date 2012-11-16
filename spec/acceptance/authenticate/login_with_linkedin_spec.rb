require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'login with linkedin' do
  before do 
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      :provider => 'linkedin',
      :uid => '12345',
      :info => { :name => 'user', :email => "user@example.com" }
    })
  end
  after { OmniAuth.config.test_mode = false }
  
  context 'created account with linkedin' do
    scenario 'valid' do
      sign_up_with_linkedin
      logout
      login_with_linkedin
      page.should have_content 'Sucessfully logged in with Linkedin!'
    end
    
    # scenario 'invalid' do
    #   sign_up_with_linkedin
    #   logout
    #   OmniAuth.config.mock_auth[:linkedin] = :invalid_credentials
    #   visit "/"
    #   click_link 'Join Now'
    #   click_link 'Sign Up with Linkedin'
    #   page.should_not have_content 'Sucessfully logged in with Linkedin!'
    # end
  end

  context 'previously linked account to linkedin' do
    scenario 'valid' do
      user = User.make!
      login(user)
      link_to_linkedin
      logout
      login_with_linkedin
      page.should have_content "Sucessfully logged in with Linkedin!"
    end
    
    # scenario 'invalid' do
    #   user = User.make!
    #   login(user)
    #   link_to_linkedin
    #   click_link 'Logout'
    #   OmniAuth.config.mock_auth[:linkedin] = :invalid_credentials
    #   login_with_linkedin
    #   page.should_not have_content "Sucessfully logged in with Linkedin!"
    # end
  end

  # # TODO: get user permission & ask for account password or new email
  # context 'previously signed up with email only, same as linkedin' do
  #   scenario 'valid'
    
  #   scenario 'invalid'
  # end
end