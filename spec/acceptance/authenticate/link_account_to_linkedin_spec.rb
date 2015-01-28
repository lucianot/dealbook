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

  context 'signed up with email' do
    scenario 'valid' do
      user = User.make!
      login(user)
      link_to_linkedin
      page.should have_content "Unlink from your Linkedin account"
    end

    scenario 'invalid'
    #   OmniAuth.config.mock_auth[:linkedin][:provider] = ''
    #   user = User.make!
    #   login(user)
    #   link_to_linkedin
    #   visit "/users/edit"
    #   page.should have_content "Link to your Linkedin account"
    # end
  end

  context 'signed up with linkedin' do
    scenario 'valid' do
      sign_up_with_linkedin
      unlink_from_linkedin
      link_to_linkedin
      page.should have_content "Unlink from your Linkedin account"
    end

    scenario 'invalid'
  end
end
