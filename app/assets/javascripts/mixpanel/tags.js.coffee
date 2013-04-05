jQuery ->
  # Nav bar guest
  mixpanel.track_forms('#search_submit', 'Search submitted')
  mixpanel.track_links('#login_link', 'Login link clicked')
  mixpanel.track_links('#signup_link', 'Sign up link clicked')

  # Nav bar user
  mixpanel.track_links('.nav .dropdown-toggle', 'Username clicked')
  $('#edit_account').click ->
    mixpanel.track('Edit account link clicked')
  $('#logout_link').click ->
    mixpanel.track('Logout link clicked')

  # Subnav bar
  mixpanel.track_links('.subnav .nav li #deals_button', 'Deals link clicked')
  mixpanel.track_links('.subnav .nav li #companies_button', 'Companies link clicked')
  mixpanel.track_links('.subnav .nav li #investors_button', 'Investors link clicked')

  # Login page
  mixpanel.track_forms('#login_form', 'Logged in')

  # Sign up page
  mixpanel.track_forms('#signup_form', 'Signed up')
