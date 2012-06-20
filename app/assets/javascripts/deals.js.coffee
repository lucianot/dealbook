jQuery ->
  $ ->
    # store investors
    company = $('#deal_company_id')
    investors = $('#deal_offerings_buyers')
    investorsOriginal = investors.find("option")
    investors.chosen()  
    company.chosen()

    # on load, remove company from options
    companyId = company.find(":selected").val()
    $('#deal_offerings_buyers option[value="Company:'+companyId+'"]').remove()
    investors.trigger("liszt:updated")

    # when company is changed, rebuilt investor options
    company.chosen().change =>

      # remove company from options
      companyId = company.find(":selected").val()
      $('#deal_offerings_buyers option[value="Company:'+companyId+'"]').remove()

      # add remaining
      investorsCurrent = investors.find("option")
      investorsOriginal.each ->
        unless this in investorsCurrent || this.value is "Company:#{companyId}"
          investors.append(this)

      investors.trigger("liszt:updated")

