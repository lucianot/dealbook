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
      click_button 'Mark as verified?'
      page.should have_content 'Verified'
    end

    scenario 'can unverify deal with source' do    
      deal = Deal.make!(:complete, :verified => true)
      login_mod
      click_link 'Deals'
      click_link "deal_#{deal.id.to_s}"
      page.should have_link deal.source_url
      page.should have_content 'Verified'
      click_button 'Mark as unverified?'
      page.should have_content 'Unverified'
    end

  end # context

  context 'when verified deal is updated' do

    scenario 'should become unverified if something changes' do
      deal = Deal.make!(:complete, :verified => true)
      login_normal
      click_link 'Deals'
      click_button "edit_#{deal.id}"
      select '2009', :from => 'Close date'
      click_button 'Update Deal'
      deal.reload
      page.should have_content 'Unverified'
      page.should_not have_content 'Verified'
    end

    scenario 'should remain verified if nothing changes' do
      deal = Deal.make!(:complete, :verified => true)
      login_normal
      click_link 'Deals'
      click_button "edit_#{deal.id}"
      click_button 'Update Deal'
      deal.reload
      page.should have_content 'Verified'
      page.should_not have_content 'Unverified'
    end

  end # context

end # feature


