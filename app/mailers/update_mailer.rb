class UpdateMailer < ActionMailer::Base
  default from: 'admin@dealbook.co'

  def update_email(company, user)
    @company = company
    @user = user
    @company_url = company_url(@company)
    mail(:to => 'luciano@tavares.us', :subject => 'New company')
  end
end
