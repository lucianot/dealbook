jQuery ->
  # $("a[rel=popover]").popover()
  # $(".tooltip").tooltip()
  # $("a[rel=tooltip]").tooltip()
  $(".alert").alert()
  $('.dropdown-toggle').dropdown()
  $(".fadeout").delay(5000).fadeOut(600);

  # # Make selected subnav option active
  # subnavOptions = $('.subnav .nav li')
  # subnavOptions.click (e) ->
  #   subnavOptions.removeClass('active')
  #   parent = $(event.target).parent('li')
  #   parent.addClass('active')
