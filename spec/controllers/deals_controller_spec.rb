require 'spec_helper'

describe DealsController do

  context "POST create" do
    before do
      @buyers = ['Investor:1']
      @attributes = { 'close_date' => '10/06/1974' }
      @attributes_with_offerings = @attributes.merge( {'offerings' => {'buyers' => @buyers}} )
      @deal = Deal.make
      Deal.stub(:new).and_return(@deal)
      controller.stub(:update_offerings_for).and_return(true)
      controller.stub(:authorize!).and_return(true)
      @deal.stub(:save).and_return(true)
    end

    context 'updates offerings' do
      before { UpdateMailer.stub_chain(:update_email, :deliver) }

      it "should assign params without offerings" do
        Deal.should_receive(:new).with(@attributes).once.and_return(@deal)
        post :create, :deal => @attributes_with_offerings
        assigns[:deal].should == @deal
      end

      it "should update offerings based on buyers" do
        controller.should_receive(:update_offerings_for).with(@deal, @buyers).once.and_return(true)
        post :create, :deal => @attributes_with_offerings
      end

      it "should create a new deal" do
        @deal.should_receive(:save).with().once.and_return(true)
        post :create, :deal => @attributes_with_offerings
        flash[:notice].should_not be_nil
        response.should redirect_to(@deal)
      end
    end

    context 'send update email' do
      before { @user = stub_mod }

      it "sends update email" do
        UpdateMailer.any_instance.should_receive(:update_email).with(@deal, @user, 'create')
        post :create, :deal => @attributes_with_offerings
      end
    end
  end

  context "PUT update" do
    before do
      @buyers = ['Investor:1']
      @attributes = { 'close_date' => '10/06/1974' }
      @attributes_with_offerings = @attributes.merge( {'offerings' => {'buyers' => @buyers}} )
      @deal = Deal.make!(:simple)
      @id = @deal.id.to_s
      Deal.stub(:find).and_return(@deal)
      controller.stub(:update_offerings_for).and_return(true)
      controller.stub(:authorize!).and_return(true)
      @deal.stub(:update_attributes).and_return(true)
      @deal.stub(:verified=)
    end

    context 'updates offerings' do
      before { UpdateMailer.stub_chain(:update_email, :deliver) }

      it "should find deal and assign it to instance variable" do
        Deal.should_receive(:find).with(@id).once.and_return(@deal)
        put :update, :id => @id, :deal => @attributes_with_offerings
        assigns[:deal].should == @deal
      end

      it "should update offerings based on buyers" do
        controller.should_receive(:update_offerings_for).with(@deal, @buyers).once.and_return(true)
        put :update, :id => @id, :deal => @attributes_with_offerings
      end

      it "should update deal" do
        @deal.should_receive(:update_attributes).with(@attributes).once.and_return(true)
        put :update, :id => @id, :deal => @attributes_with_offerings
        flash[:notice].should_not be_nil
        response.should redirect_to(@deal)
      end
    end

    context 'send update email' do
      before do
        @user = stub_mod
      end

      it "sends update email" do
        UpdateMailer.any_instance.should_receive(:update_email).with(@deal, @user, 'update')
        put :update, :id => @id, :deal => @attributes_with_offerings
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @deal = Deal.make!(:simple)
      @user = stub_mod
      Deal.stub(:find).with(@deal.id.to_s).and_return(@deal)
    end

    it "sends update email" do
      UpdateMailer.any_instance.should_receive(:update_email).with(@deal, @user, 'destroy')
      delete :destroy, :id => @deal.id
    end
  end

  context "#update_offerings_for" do
    it "should create offerings for new buyers" do
      @deal = Deal.make!(:simple)
      offering = @deal.offerings.first
      buyers = ["#{offering.buyer_type}:#{offering.buyer_id}", "Investor:10"]
      expect { update_offerings_for(@deal, buyers) }.to change{ @deal.offerings.count }.from(1).to(2)
    end

    it "should delete offerings if buyer was unselected" do
      @deal = Deal.make!(:complete)
      offering = @deal.offerings.first
      buyers = ["#{offering.buyer_type}:#{offering.buyer_id}"]
      expect { update_offerings_for(@deal, buyers) }.to change{ @deal.offerings.count }.from(3).to(1)
    end
  end
end

def stub_mod
  user = User.make!(:mod)
  controller.stub(:current_user).and_return(user)
  user
end