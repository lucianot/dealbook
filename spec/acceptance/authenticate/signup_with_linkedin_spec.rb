require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'signup with linkedin' do
  LINKEDIN_INFO = {
    "email-address" => 'user@example.com'
  }

  before do 
    authhash = {
      :provider => 'linkedin',
      :uid => '12345',
      :info => LINKEDIN_INFO
    }
    OmniAuth.config.test_mode = true
    # OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new(authhash)
    OmniAuth.config.add_mock(:linkedin, :provider => 'linkedin',
                                        :uid => '12345',
                                        :info => LINKEDIN_INFO)
  end
  
  after { OmniAuth.config.test_mode = false }

  scenario 'valid' do
    visit "/"
    click_link 'Join Now'
    click_link 'Sign Up with Linkedin'
    response.should_not == nil
    json = ActiveSupport::JSON.decode(response.body)

    json["uid"].should == '12345'
    json["provider"].should == 'linkedin'
    # json["info"]["email-address"] == 'user@example.com'
  end

  scenario 'invalid'
end



