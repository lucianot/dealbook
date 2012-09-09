require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'manage linkedin account associated' do
  context 'association' do
    before do 
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:linkedin] = {
        "uid" => '12345',
        "provider" => 'linkedin',
        "user_info" => {"nickname" => 'dude'},
        "credentials" => {"token" => 'sweet'},
        "extra" => {"user_hash" => LINKEDIN_HASH} 
        }
    end
    after { OmniAuth.config.test_mode = false }
    
    scenario 'connect' do
      login_normal
      visit "/users/edit"
      click_link 'Connect to Linkedin'
      page.should have_content "Success! Your Linkedin account is connected."
      page.should have_content "Disconnect Linkedin account"
    end 
    
    scenario 'connected' do
      login_normal
      visit "/users/edit"
      page.should have_content "Disconnect Linkedin account"
    end
    
    scenario 'disconnect' do
      login_linkedin
      visit "/users/edit"
      click_link 'Disconnect Linkedin account'
      page.should have_content "Successfuly disconnect your Linkedin account"
      page.should have_content "Connect to Linkedin"
    end   
  end
end