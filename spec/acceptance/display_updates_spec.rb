require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display updates' do

  context 'to normal user' do

    scenario 'when no deals' do
      login_normal
      visit '/'
      page.should have_content 'No updates'
    end

    scenario 'when one or more deals' do
      deal = Deal.make!(:complete)
      login_normal
      visit '/'
      page.should have_link "#{deal.headline}"
      page.should_not have_content 'No updates'
    end

    scenario 'show deal' do
      deal = Deal.make!(:complete)
      login_normal
      visit '/'
      click_link "#{deal.headline}"
      page.should_not have_content 'No updates'
      page.should have_content deal.company_name
      page.should have_content deal.category
      page.should have_content deal.round
    end

  end
end