require 'spec_helper'

describe Company do
  subject { @company }

  before { @company = Company.make }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Validations
  context 'validations' do
    before { Company.make!(:name => @company.name) }

    it { should have_valid(:name).when('a'*2, 'a'*100) }
    it { should_not have_valid(:name).when('a', 'a'*101, nil) }
    it { should validate_uniqueness_of(:name) }

    it { should have_valid(:description).when('some_description', '', nil) }
    it { should_not have_valid(:description).when('a'*601) }

    it { should have_valid(:website).when('http://techcrunch.com', '', nil) }
    it { should_not have_valid(:website).when('http://invalid') }

    it { should have_valid(:linkedin).when('http://www.linkedin.com/company/' + rand(100_000).to_s, '', nil) }
    it { should_not have_valid(:linkedin).when('http://invalid') }

    it { should have_valid(:status).when('acquired', 'active', nil) }
    it { should_not have_valid(:status).when('invalid', '') }
  end

  # Associations
  context 'associations' do
    it { should have_and_belong_to_many(:markets) }
    it { should have_and_belong_to_many(:locations) }
    it { should have_many(:offers) }
    it { should have_many(:offerings).through(:offers) }
    it { should have_many(:investors).through(:offerings) }
    it { should have_many(:corporates).through(:offerings) }
    it { should have_many(:dealings) }
    it { should have_many(:deals).through(:dealings) }
    it { should have_many(:companies).through(:deals) }
  end

end
