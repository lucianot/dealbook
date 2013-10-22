require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display deals' do

  context 'guest' do

    scenario 'no deals' do
      visit '/'
      find('#deals_button').click
      page.should have_content 'No deals yet'
    end

    scenario 'one or more deals' do
      deal = Deal.make!(:complete)
      visit '/'
      find('#deals_button').click
      page.should have_link "deal_#{deal.id.to_s}"
      page.should_not have_content 'No deals yet'
    end

    scenario 'show deal' do
      deal = Deal.make!(:complete)
      visit '/'
      find('#deals_button').click
      click_link "deal_#{deal.id.to_s}"
      page.should have_content deal.company_name
      page.should have_content deal.category
      page.should have_content deal.round
      page.should_not have_link 'Edit'
      page.should_not have_link 'Destroy'
      page.should have_link 'Back'
    end
  end

  context 'user' do
    scenario 'show deal' do
      deal = Deal.make!(:complete)
      login_normal
      find('#deals_button').click
      click_link "deal_#{deal.id.to_s}"
      page.should have_content deal.company_name
      page.should have_content deal.category
      page.should have_content deal.round
      page.should have_link 'Edit'
      page.should have_link 'Destroy'            
      page.should have_link 'Back'
    end
  end
end