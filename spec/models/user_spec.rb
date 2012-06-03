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

    it { should have_valid(:role).when( *User::ROLES ) }
    it { should_not have_valid(:role).when('invalid', '', nil) }
  end

  # Associations

  # # Class methods
  # context '#top_role' do
  #   before do 
  #     @admin = User.make!
  #   end

  #   it 'should return top role if has role' do
  #     @admin.add_role :admin
  #     @admin.add_role :normal
  #     @admin.top_role.should == "Admin"
  #   end

  #   it 'should return top role if has no role' do
  #     @admin.top_role.should be_nil
  #   end    
  # end
end
