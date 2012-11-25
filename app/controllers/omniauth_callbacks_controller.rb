class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    auth = request.env["omniauth.auth"]
    if user_signed_in?
      if current_user.update_attributes({:provider => auth.provider, :uid => auth.uid})
        redirect_to "/users/edit", notice: "Your Linkedin account has been linked to your profile."
      end
    else
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
  end
  alias_method :linkedin, :all
end