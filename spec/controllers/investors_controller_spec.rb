require 'spec_helper'

describe InvestorsController do

  describe "POST create" do
    before do
      @attr = { 'name' => 'Anything' }
      @investor = Investor.make
      @user = stub_mod
      Investor.stub(:new).with(@attr).and_return(@investor)
    end

    it "sends update email" do
      UpdateMailer.any_instance.should_receive(:update_email).with(@investor, @user, 'create')
      post :create, :investor => @attr
    end
  end

  describe "PUT update" do
    before do
      @attr = { 'name' => 'Something Else' }
      @investor = Investor.make!
      @user = stub_mod
      Investor.stub(:find).with(@investor.id.to_s).and_return(@investor)
    end

    it "sends update email" do
      UpdateMailer.any_instance.should_receive(:update_email).with(@investor, @user, 'update')
      put :update, :id => @investor.id, :investor => @attr
    end
  end

  describe "DELETE destroy" do
    before do
      @investor = Investor.make!
      @user = stub_mod
      Investor.stub(:find).with(@investor.id.to_s).and_return(@investor)
    end

    it "sends update email" do
      UpdateMailer.any_instance.should_receive(:update_email).with(@investor, @user, 'destroy')
      delete :destroy, :id => @investor.id
    end
  end
end

def stub_mod
  user = User.make!(:mod)
  controller.stub(:current_user).and_return(user)
  user
end
