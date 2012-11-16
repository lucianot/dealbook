class UnlinkController < ApplicationController
  def create
    @user = current_user 
    @user.unlink_from_linkedin
    redirect_to "/users/edit", notice: "Your Linkedin account has been unlinked from your profile."
  end
end