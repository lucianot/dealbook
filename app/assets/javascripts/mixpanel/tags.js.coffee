jQuery ->
  # $(".subnav .nav li #deals_button").click (e) ->
  #   mixpanel.track("Deals button clicked")
  mixpanel.track_links('.subnav .nav li #deals_button', 'Deals button clicked')
  mixpanel.track_links('.subnav .nav li #companies_button', 'Companies button clicked')
  mixpanel.track_links('.subnav .nav li #investors_button', 'Investors button clicked')
