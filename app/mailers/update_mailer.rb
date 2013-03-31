class UpdateMailer < ActionMailer::Base
  default from: 'admin@dealbook.co'

  def update_email(object, user, action)
    @object = object
    @user = user
    @action = action

    @model = @object.class.to_s
    @subject = subject
    @header = header
    @object_title = title
    @object_url = url

    mail(:to => 'luciano@tavares.us', :subject => @subject)
  end

  private

  def subject
    case @action
    when 'create'
      "New #{@model.downcase}"
    when 'update'
      "#{@model} updated"
    when 'destroy'
      "#{@model} deleted"
    end
  end

  def header
    case @action
    when 'create'
      "A new #{@model.downcase} has just been added to Dealbook:"
    when 'update'
      "#{preposition} #{@model.downcase} has just been updated on Dealbook:"
    when 'destroy'
      "#{preposition} #{@model.downcase} has just been deleted from Dealbook:"
    end
  end

  def title
    @model == 'Deal' ? @object.headline : @object.name
  end

  def url
    if @action == 'destroy'
      ''
    else
      case @model
      when 'Company'
        company_path(@object)
      when 'Investor'
        investor_path(@object)
      when 'Deal'
        deal_path(@object)
      end
    end
  end

  def preposition
    @model == 'Investor' ? 'An' : 'A'
  end
end