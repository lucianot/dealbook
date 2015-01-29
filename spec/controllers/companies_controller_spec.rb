require 'spec_helper'

describe CompaniesController do

  describe "POST create" do
    before do
      @attr = { 'name' => 'Anything' }
      @company = Company.make
      @user = stub_mod
      Company.stub(:new).with(@attr).and_return(@company)
    end

    it "sends update email" do
      UpdateMailer.any_instance.should_receive(:update_email).with(@company, @user, 'create')
      post :create, company: @attr
    end
  end

  describe "PUT update" do
    before do
      @attr = { 'name' => 'Something Else' }
      @company = Company.make!
      @user = stub_mod
      Company.stub(:find).with(@company.id.to_s).and_return(@company)
    end

    it "sends update email" do
      UpdateMailer.any_instance.should_receive(:update_email).with(@company, @user, 'update')
      put :update, id: @company.id, company: @attr
    end
  end

  describe "DELETE destroy" do
    before do
      @company = Company.make!
      @user = stub_mod
      Company.stub(:find).with(@company.id.to_s).and_return(@company)
    end

    it "sends update email" do
      UpdateMailer.any_instance.should_receive(:update_email).with(@company, @user, 'destroy')
      delete :destroy, id: @company.id
    end
  end
end

def stub_mod
  user = User.make!(:mod)
  controller.stub(:current_user).and_return(user)
  user
end
