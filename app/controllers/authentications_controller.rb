class AuthenticationsController < ApplicationController

  def unlink
    current_user.unlink_from_linkedin if current_user
    redirect_to "/users/edit", notice: "Your Linkedin account has been unlinked from your profile."
  end
end