require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'unlink account from linkedin' do
  before do 
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      :provider => 'linkedin',
      :uid => '12345',
      :info => { :name => 'user', :email => "user@example.com" }
    })
  end
  after { OmniAuth.config.test_mode = false }
  
  context 'user has password' do
    scenario 'unlink successful' do
       sign_up_new_user
       link_linkedin
       login_linkedin
       visit "/users/edit"
       visit "/users/unlink"
       page.should have_content "Your LinkedIn account has been unlinked from your profile."
    end
  end

  context 'user never created password' do
    scenario 'valid'
    scenario 'invalid'
  end
end