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

  # Methods
  context '.from_omniauth' do
    it 'creates an user when one does not exist' do
      auth = OmniAuth::AuthHash.new({
        provider: 'linkedin',
        uid: '12345',
        info: { name: 'user', email: "user@example.com" }
      })
      expect do
        User.from_omniauth(auth)
      end.to change {User.count}.by(1)
    end

    it 'finds the user when it already exists' do
      user = User.make!(:linkedin)
      auth = OmniAuth::AuthHash.new({
        provider: 'linkedin',
        uid: '12345',
        info: { name: user.full_name, email: user.email }
      })
      expect do
        user2 = User.from_omniauth(auth)
        user2.should == user
      end.to change {User.count}.by(0)
    end
  end

  context '#is?' do
    let(:admin) { User.make!(:admin) }

    it 'is true if admin' do
      admin.is?(:admin).should be_true
    end

    it 'is false if admin' do
      admin.is?(:normal).should be_false
    end
  end

  context '#password_required?' do
    it 'is true is when provider is blank' do
      user = User.make
      user.password_required?.should == true
    end

    it 'is false when provider is present' do
      user = User.make(:linkedin)
      user.password_required?.should == false
    end
  end
end
