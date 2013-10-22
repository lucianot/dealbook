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

  context 'user created account via email' do
    scenario 'unlink successful' do
      sign_up_new_user
      link_to_linkedin
      logout
      login_with_linkedin
      unlink_from_linkedin
      page.should have_content "Your Linkedin account has been unlinked from your profile"
    end
  end

  # context 'user created account via linkedin' do
  #   scenario 'unlink successful' do
  #      sign_up_with_linkedin
  #      unlink_from_linkedin
  #      page.should have_content "Your Linkedin account has been unlinked from your profile."
  #   end
  # end
end