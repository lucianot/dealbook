require 'spec_helper'

describe CompaniesController do

  describe "POST create" do
    before do
      @attr = { 'name' => 'anything' }
      @company = Company.make
      @user = stub_mod
      Company.stub(:new).with(@attr).and_return(@company)
    end

    it "sends update email" do
      UpdateMailer.any_instance.should_receive(:update_email).with(@company, @user)
      post :create, :company => @attr
    end
  end
end

def stub_mod
  user = User.make!(:mod)
  controller.stub(:current_user).and_return(user)
  user
end