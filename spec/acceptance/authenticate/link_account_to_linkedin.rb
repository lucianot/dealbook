require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'manage linkedin association' do

  context 'link account to linkedin' do
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
    
    scenario 'valid linkedin credentials' do
      login_normal
      visit "/users/edit"
      click_link 'Link to your Linkedin account'
      # Insert credentials?
      page.should have_content "Success! Your Linkedin account is linked."
      page.should have_content "Unlink Linkedin account"
    end 

    scenario 'invalid linkedin credentials' do
      login_normal
      visit "/users/edit"
      click_link 'Link to your Linkedin account'
      # Insert credentials?
      page.should have_content "Invalid Linkedin account"
      page.should have_content "Link to your Linkedin account"
    end 
  end
    
  context 'unlink account from linkedin' do
    scenario 'unlink successful' do
      login_normal
      visit "/users/edit"
      click_link 'Disconnect Linkedin account'
      page.should have_content "Success! Your Linkedin account is linked."
      page.should have_content "Link to your Linkedin account"
    end   
  end
end

