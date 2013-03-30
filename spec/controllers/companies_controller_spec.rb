require 'spec_helper'

describe CompaniesController do

  describe "POST create" do
    before do
      fake_user
      @attr = { 'name' => 'anything' }
      @company = Company.make
      Company.stub(:new).with(@attr).and_return(@company)
    end

    it "sends update email" do
      UpdateMailer.any_instance.should_receive(:update_email)
      post :create, :company => @attr
    end
  end
end

# def login_as_mod
#   user = User.make!(:mod)
#   session[:user_id] = user.id
# end

def fake_user
  user = User.make!(:mod)
  controller.stub(:current_user).and_return(user)
end