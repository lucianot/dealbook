require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'authenticate with linkedin' do
  # context 'guest first login' do
  #   before do 
  #     OmniAuth.config.test_mode = true
  #     OmniAuth.config.mock_auth[:linkedin] = {
  #       "uid" => '12345',
  #       "provider" => 'linkedin',
  #       "user_info" => {"nickname" => 'dude'},
  #       "credentials" => {"token" => 'sweet'},
  #       "extra" => {"user_hash" => LINKEDIN_HASH} 
  #     }
  #   end

  #   after { OmniAuth.config.test_mode = false }

  #   scenario 'valid' do
  #     visit "/"
  #     click_link 'Join Now'
  #     click_link 'Sign Up with Linkein'

  #     page.should have_content "Welcome! You have signed up successfully"
  #   end
 
  #   scenario 'invalid' do
  #     visit "/"
  #     click_link 'Join Now'
  #     click_link 'Sign Up with Email'
  #     click_button 'Sign up'
  #     page.should have_content "Please review the problems below"
  #   end
  # end
end