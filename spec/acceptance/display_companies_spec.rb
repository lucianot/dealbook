require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display companies' do
  
  scenario 'no links' do
    visit "/companies"
    page.should have_content "No companies yet"
  end
  
  scenario 'one or more links' do
    company = Company.make!
    visit "/companies"
    page.should have_content company.name
    page.should_not have_content "No companies yet"
  end
end