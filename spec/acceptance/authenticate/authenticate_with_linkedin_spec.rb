require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'authenticate with linkedin' do
  context 'guest first login' do
    scenario 'valid'
    scenario 'invalid'
  end

  context 'previously signed up with linkedin only' do
    scenario 'valid'
    scenario 'invalid'
  end

  context 'previously linked account to linkedin' do
    scenario 'valid'
    scenario 'invalid'
  end

  context 'previously signed up with email only' do
    scenario 'valid'
    scenario 'invalid'
  end
end