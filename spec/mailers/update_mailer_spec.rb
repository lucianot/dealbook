require 'spec_helper'

describe UpdateMailer do
  describe '#update_email' do
    before { UpdateMailer.update_email.deliver }

    let(:mail) { ActionMailer::Base.deliveries.first }

    it 'renders the subject' do
      mail.subject.should == 'New company'
    end
 
    it 'renders the receiver email' do
      mail.to.should == ['luciano@tavares.us']
    end

    it 'renders the sender email' do
      mail.from.should == ['notifications@dealbook.co']
    end
  end
end