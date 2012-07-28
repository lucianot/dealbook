# if ["development", "production"].include?(Rails.env)
#   MIXPANEL_TOKEN = "6bedf8cb9a575c42f8020fba93dfd234"
#   Dealbook::Application.config.middleware.use "Mixpanel::Tracker::Middleware", MIXPANEL_TOKEN
# else
#   class DummyMixpanel
#     def method_missing(m, *args, &block)
#       true
#     end
#   end
# end