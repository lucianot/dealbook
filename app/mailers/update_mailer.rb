class UpdateMailer < ActionMailer::Base
  default from: 'notifications@dealbook.co'

  def update_email
    mail(:to => 'luciano@tavares.us', :subject => 'New company')
  end
end
