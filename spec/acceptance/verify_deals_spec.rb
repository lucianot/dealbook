require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'verify deals' do

  context 'normal user' do

    scenario 'cannot verify deals' do
      deal = Deal.make!(:complete)
      normal = login_normal
      click_link 'Deals'
      click_link "deal_#{deal.id.to_s}"
      page.should_not have_link 'Mark as verified?'
    end

  end

  context 'moderator' do

    scenario 'cannot verify deal without source_url' do
      deal = Deal.make!(:complete, :source_url => nil)
      login_mod
      click_link 'Deals'
      click_link "deal_#{deal.id.to_s}"
      page.should_not have_content 'Verified'
      page.should_not have_link 'Mark as verified?'
    end

    scenario 'can verify deal with source' do
      deal = Deal.make!(:complete)
      login_mod
      click_link 'Deals'
      click_link "deal_#{deal.id.to_s}"
      page.should have_link deal.source_url
      page.should have_content 'Unverified'
      click_link 'Mark as verified?'
      page.should have_content 'Verified'
    end

    scenario 'can unverify deal with source' do
      deal = Deal.make!(:complete, :verified => true)
      login_mod
      click_link 'Deals'
      click_link "deal_#{deal.id.to_s}"
      page.should have_link deal.source_url
      page.should have_content 'Verified'
      click_link 'Mark as unverified?'
      page.should have_content 'Unverified'
    end

  end # context

  context 'when deal is updated' do

    scenario 'should become unverified' do
      deal = Deal.make!(:complete, :verified => true)
      login_normal
      click_link 'Deals'
      click_link "edit_#{deal.id}"
      select '2009', :from => 'Close date'
      click_button 'Update Deal'
      deal.reload
      click_link "deal_#{deal.id.to_s}"
      page.should have_content 'Unverified'
      page.should_not have_content 'Verified'
    end

  end # context

end # feature


