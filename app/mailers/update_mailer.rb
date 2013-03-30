class UpdateMailer < ActionMailer::Base
  default from: 'admin@dealbook.co'

  def update_email(company, user, action)
    @company = company
    @user = user

    @company_url = company_url(@company)
    @subject = subject(action)
    @header = header(action)

    mail(:to => 'luciano@tavares.us', :subject => @subject)
  end

  def subject(action)
    if action == 'create'
      'New company'
    elsif action == 'update'
      'Company updated'
    end
  end

  def header(action)
    if action == 'create'
      'A new company has just been added to Dealbook:'
    elsif action == 'update'
      'A company has just been updated on Dealbook:'
    end
  end
end
