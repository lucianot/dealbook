class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)

    if user.persisted?
      user.update_attributes({:provider => auth.provider, :uid => auth.uid})
      flash.notice = "Sucessfully logged in with Linkedin!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end

  end
  alias_method :linkedin, :all
end