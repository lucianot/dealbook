class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  # before_filter :initialize_mixpanel

  # def initialize_mixpanel
  #   @mixpanel = Mixpanel::Tracker.new("6bedf8cb9a575c42f8020fba93dfd234", request.env, true)
  # end

  # def initialize_mixpanel
  #   if defined?(MIXPANEL_TOKEN)
  #     @mixpanel = Mixpanel.new(MIXPANEL_TOKEN, request.env)
  #   else
  #     @mixpanel = DummyMixpanel.new
  #   end
  # end
end
