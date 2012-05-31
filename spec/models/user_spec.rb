require 'spec_helper'

describe User do
  before(:each) { @user = User.make }
  subject { @user }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Validations
  context 'validations' do  
    it { should have_valid(:full_name).when('Lorem::Name.name') }
    it { should_not have_valid(:full_name).when('a', 'a'*101, '', nil) }
  end

  # Associations
  context 'associations' do
    it { should have_and_belong_to_many(:roles) }
  end


  # # Class methods
  # context '#has_role?' do
  #   before do 
  #     roles = []
  #     roles << Role.make(:admin)
  #     @admin = User.make!(:roles => roles)
  #   end

  #   it 'should return true if user has role' do
  #     @admin.has_role?('admin').should be_true
  #   end
  # end
end
