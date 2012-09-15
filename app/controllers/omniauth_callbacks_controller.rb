class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    # raise request.env["omniauth.auth"].to_yaml
    user = User.find_for_linkedin_oauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect user, notice: "Signed in!"
    else
      redirect_to new_user_registration_url
    end
  end
  alias_method :linkedin, :all
end
