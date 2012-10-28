require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'unlink account from linkedin' do

  context 'user has password' do
    # scenario 'unlink successful' do
    #    sign_up_new_user
    #    link_linkedin
    #    login_linkedin
    #    visit "/users/edit"
    #    click_link 'Unlink Linkedin account'
    #    page.should have_content "Your Linkedin account has been unlinked from your profile."
    # end
  end

  context 'user never created password' do
    scenario 'valid'
    scenario 'invalid'
  end
end