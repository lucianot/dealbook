require 'spec_helper'

describe UpdateMailer do
  describe '#update_email' do
    let(:mail)    { ActionMailer::Base.deliveries.first }
    let(:user)    { User.make }

    before do
      @company = Company.make!
      UpdateMailer.update_email(@company, user).deliver
    end

    it 'renders the subject' do
      mail.subject.should == 'New company'
    end
 
    it 'renders the receiver email' do
      mail.to.should == ['luciano@tavares.us']
    end

    it 'renders the sender email' do
      mail.from.should == ['admin@dealbook.co']
    end

    it 'assigns @company' do
      mail.body.encoded.should match(@company.name)
    end

    it 'assigns @company_url' do
      mail.body.encoded.should match("/companies/#{@company.slug}")
    end

    it 'assigns @user' do
      mail.body.encoded.should match(user.full_name)
    end
  end
end