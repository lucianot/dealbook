require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'manage investors' do
  
  context 'unauthenticated user' do

    scenario 'cannot manage investors' do
      visit '/'
      click_link 'Investors'
      page.should_not have_link 'New Investor'
      page.should_not have_link 'Edit'
      page.should_not have_link 'Destroy'    
    end

  end # context

  context 'regular user' do

    scenario 'can create new investor' do
      investor = Investor.make
      login_normal
      click_link 'Investors'
      click_link 'New Investor'
      fill_in 'Name', :with => investor.name
      fill_in 'Description', :with => investor.description
      fill_in 'Website', :with => investor.website
      fill_in 'Linkedin', :with => investor.linkedin 
      select 'VC', :from => 'Category'      
      select 'active', :from => 'Status'
      expect do
        click_button 'Submit'
      end.to change {Investor.count}.by(1)
      page.should have_content 'Investor was successfully created.'
      page.should have_content investor.name
    end

    scenario 'can edit investors' do
      investor = Investor.make!
      new_name = "#{investor.name} Clone"
      login_normal
      click_link 'Investors'
      click_link 'Edit'
      fill_in 'Name', :with => new_name
      expect do
        click_button 'Submit'
      end.to change {Investor.count}.by(0)
      page.should have_content 'Investor was successfully updated.'
      page.should have_content new_name
    end

    scenario 'can delete investors' do
      investor = Investor.make!
      login_normal
      click_link 'Investors'
      expect do      
        click_link 'Destroy'
      end.to change {Investor.count}.by(-1)
      page.should have_content 'Investor was successfully deleted.'
      page.should_not have_content investor.name      
    end

  end # context

end # feature
