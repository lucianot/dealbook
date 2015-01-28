class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!

  def unlink
    if current_user.update_attributes({:provider => nil, :uid => nil})
      redirect_to "/users/edit", notice: "Your Linkedin account has been unlinked from your profile."
    end
  end
end
