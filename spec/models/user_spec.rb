require 'spec_helper'

describe User do
  before { @user = User.make }
  subject { @user }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Validations
  context 'validations' do  
    it { should have_valid(:full_name).when('Lorem::Name.name') }
    it { should_not have_valid(:full_name).when('a', 'a'*101, '', nil) }

    it { should have_valid(:role).when( *User::ROLES ) }
    it { should_not have_valid(:role).when('invalid', '', nil) }
  end

  # Class methods
  context '#is?' do
    before do 
      @admin = User.make!(:admin)
    end

    it 'should be true if admin' do
      @admin.is?(:admin).should be_true
    end

    it 'should be false if admin' do
      @admin.is?(:normal).should be_false
    end
  end

end


