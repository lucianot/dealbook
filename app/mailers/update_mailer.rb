class UpdateMailer < ActionMailer::Base
  default from: 'Dealbook Admin <admin@dealbook.co>'

  def update_email(object, user, action)
    @object = object
    @user = user
    @action = action

    @model = @object.class.to_s
    @subject = subject
    @header = header
    @object_title = title
    @object_url = url

    mods = ['luciano@tavares.us', 'diego.ttg@gmail.com']
    mail(to: mods, subject: @subject)
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
    @action == 'destroy' ? '' : url_for(@object)
  end

  def preposition
    @model == 'Investor' ? 'An' : 'A'
  end
end
