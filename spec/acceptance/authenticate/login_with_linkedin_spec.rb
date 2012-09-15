require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'login with linkedin' do
  context 'previously signed up with linkedin only' do
    scenario 'valid'
    scenario 'invalid'
  end

  context 'previously linked account to linkedin' do
    scenario 'valid'
    scenario 'invalid'
  end

  # TODO: decide whether to just link or get user permission
  context 'previously signed up with email only, same as linkedin' do
    scenario 'valid'
    scenario 'invalid'
  end
end