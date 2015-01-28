require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'signup with linkedin' do

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      :provider => 'linkedin',
      :uid => '12345',
      :info => { :name => 'user', :email => "user@example.com" }
    })
  end
  after { OmniAuth.config.test_mode = false }

  scenario 'using valid data' do
    sign_up_with_linkedin
    page.should have_content 'Sucessfully logged in with Linkedin!'
  end

  scenario 'using blank email' do
    OmniAuth.config.mock_auth[:linkedin][:info][:email] = ''
    sign_up_with_linkedin
    page.should have_content "can't be blank"
  end

  scenario 'using existing email' do
    user = sign_up_new_user
    logout
    OmniAuth.config.mock_auth[:linkedin][:info][:email] = user.email
    sign_up_with_linkedin
    page.should have_content "has already been taken"
  end

end
