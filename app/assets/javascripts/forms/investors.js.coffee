jQuery ->
  if $('body.investors').length > 0
    $('#investor_stage').chosen()
    $('#investor_market_ids').chosen()
    $('#investor_location_ids').chosen()