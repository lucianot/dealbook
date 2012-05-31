require 'spec_helper'

describe Role do
  before(:each) { @role = Role.make }
  subject { @role }

  # # Valid
  # context 'when has valid attributes' do
  #   it { should be_valid }
  # end

  # # Validations
  # context 'validations' do
  #   it { should have_valid(:name).when('Admin') }
  #   it { should_not have_valid(:name).when('invalid', '', nil) }
  # end

  # Associations
  context 'associations' do
    it { should have_and_belong_to_many(:users) }
  end
end
