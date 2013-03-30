class UpdateMailer < ActionMailer::Base
  default from: 'admin@dealbook.co'

  def update_email(company, user, action)
    @company = company
    @user = user
    @action = action

    @company_url = action != 'destroy'? company_url(@company) : ''
    @subject = subject
    @header = header

    mail(:to => 'luciano@tavares.us', :subject => @subject)
  end

  def subject
    case @action
    when 'create'
      'New company'
    when 'update'
      'Company updated'
    when 'destroy'
      'Company deleted'      
    end
  end

  def header
    case @action
    when 'create'
      'A new company has just been added to Dealbook:'
    when 'update'
      'A company has just been updated on Dealbook:'
    when 'destroy'
      'A company has just been deleted from Dealbook:'      
    end
  end
end
