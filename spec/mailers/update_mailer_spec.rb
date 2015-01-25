require 'spec_helper'

describe UpdateMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  describe '#update_email' do
    before { reset_mailer }

    let(:mail) { ActionMailer::Base.deliveries.first }
    let(:user) { User.make }

    context 'when object is company' do
      before { @company = Company.make! }

      context 'when action is create' do
        before { UpdateMailer.update_email(@company, user, 'create').deliver }

        it 'renders the subject' do
          mail.subject.should == 'New company'
        end

        it 'renders the receiver email' do
          mail.to.should == ['luciano@tavares.us', 'diego.ttg@gmail.com']
        end

        it 'renders the sender email' do
          mail.from.should == ['admin@dealbook.co']
        end

        it 'renders the header' do
          mail.body.encoded.should match('A new company has just been added to Dealbook:')
        end

        it 'assigns company' do
          mail.body.encoded.should match(@company.name)
        end

        it 'assigns url' do
          mail.body.encoded.should match("/companies/#{@company.slug}")
        end

        it 'assigns user' do
          mail.body.encoded.should match(user.full_name)
        end
      end

      context 'when action is update' do
        before { UpdateMailer.update_email(@company, user, 'update').deliver }

        it 'renders the subject' do
          mail.subject.should == 'Company updated'
        end
      end

      context 'when action is destroy' do
        before { UpdateMailer.update_email(@company, user, 'destroy').deliver }

        it 'renders the subject' do
          mail.subject.should == 'Company deleted'
        end
      end
    end

    context 'when object is investor' do
      before { @investor = Investor.make! }

      context 'when action is create' do
        before { UpdateMailer.update_email(@investor, user, 'create').deliver }

        it 'renders the subject' do
          mail.subject.should == 'New investor'
        end

        it 'renders the header' do
          mail.body.encoded.should match("A new investor has just been added to Dealbook:")
        end

        it 'assigns @object' do
          mail.body.encoded.should match(@investor.name)
        end

        it 'assigns @url' do
          mail.body.encoded.should match("/investors/#{@investor.slug}")
        end
      end

      context 'when action is update' do
        before { UpdateMailer.update_email(@investor, user, 'update').deliver }

        it 'renders the subject' do
          mail.subject.should == 'Investor updated'
        end
      end

      context 'when action is destroy' do
        before { UpdateMailer.update_email(@investor, user, 'destroy').deliver }

        it 'renders the subject' do
          mail.subject.should == 'Investor deleted'
        end
      end
    end

    context 'when object is deal' do
      before { @deal = Deal.make!(:simple) }

      context 'when action is create' do
        before { UpdateMailer.update_email(@deal, user, 'create').deliver }

        it 'renders the subject' do
          mail.subject.should == 'New deal'
        end

        it 'renders the header' do
          mail.body.encoded.should match("A new deal has just been added to Dealbook:")
        end

        it 'assigns @object' do
          mail.body.encoded.should match(@deal.headline)
        end

        it 'assigns @url' do
          mail.body.encoded.should match("/deals/#{@deal.id}")
        end
      end

      context 'when action is update' do
        before { UpdateMailer.update_email(@deal, user, 'update').deliver }

        it 'renders the subject' do
          mail.subject.should == 'Deal updated'
        end
      end

      context 'when action is destroy' do
        before { UpdateMailer.update_email(@deal, user, 'destroy').deliver }

        it 'renders the subject' do
          mail.subject.should == 'Deal deleted'
        end
      end
    end
  end
end
