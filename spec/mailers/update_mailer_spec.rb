require 'spec_helper'

describe UpdateMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  describe '#update_email' do
    let(:mail)    { ActionMailer::Base.deliveries.first }
    let(:user)    { User.make }

    before do
      reset_mailer
      @company = Company.make!
    end

    context 'when company created' do
      before { UpdateMailer.update_email(@company, user, 'create').deliver }
        
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

    context 'when company updated' do
      before { UpdateMailer.update_email(@company, user, 'update').deliver }

      it 'renders the subject' do
        mail.subject.should == 'Company updated'
      end
    end

    context 'when company deleted' do
      before { UpdateMailer.update_email(@company, user, 'destroy').deliver }

      it 'renders the subject' do
        mail.subject.should == 'Company deleted'
      end
    end
  end
end