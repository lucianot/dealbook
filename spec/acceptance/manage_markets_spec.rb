require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'manage markets' do

  context 'moderator/admin' do

    scenario 'can create new market' do
      market = Market.make
      login_mod
      click_link 'Markets'
      click_button 'New Market'
      fill_in 'Name', :with => market.name
      expect do
        click_button 'Create Market'
      end.to change {Market.count}.by(1)
      page.should have_content 'Market was successfully created.'
      page.should have_content market.name
    end

    scenario 'can edit markets' do
      market = Market.make!
      login_mod
      click_link 'Markets'
      click_link "edit_#{market.id}"
      fill_in 'Name', :with => 'mobile'
      click_button 'Update Market'
      page.should have_content 'Market was successfully updated.'
      page.should have_content 'mobile'
    end

    scenario 'can delete markets' do
      market = Market.make!
      login_mod
      click_link 'Markets'
      page.should have_link "destroy_#{market.id}"
      expect do
        click_link "destroy_#{market.id}"  
      end.to change {Market.count}.by(-1)
      page.should have_content 'Market was successfully deleted.'
      page.should_not have_content market.name
      uri = URI.parse(current_url)
      uri.path.should == '/markets'
    end

  end # context mod/admin

end