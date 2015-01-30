require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'edit account info' do
  context 'change name' do
    scenario 'valid'
    scenario 'invalid'
  end

  # TODO: check scenario where new email matches another linkedin account
  context 'change email' do
    scenario 'valid'
    scenario 'invalid'
  end

  context 'change password or add to linkedin account' do
    scenario 'valid'
    scenario 'invalid'
  end
end
