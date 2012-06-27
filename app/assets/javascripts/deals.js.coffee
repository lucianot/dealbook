jQuery ->
  $ ->
    company = $('#deal_company_id')
    category = $('#deal_category')
    investors = $('#deal_offerings_buyers')
    round = $('#deal_round')
    currency = $('#deal_currency')
    amount = $('#deal_amount')
    valuation = $('#deal_pre_valuation')

    # store investors
    investorsOriginal = investors.find("option")
    investors.chosen()
    company.chosen()

    # on load, remove company from options
    companyId = company.find(":selected").val()
    $('#deal_offerings_buyers option[value="Company:'+companyId+'"]').remove()
    investors.trigger("liszt:updated")

    # autonumeric amount
    amount.autoNumeric({vMin: '0', vMax: '999999999999', mDec: '0'});
    amount_value = amount.autoNumericGet()
    amount.autoNumericSet(amount_value) if amount_value && amount_value > 0

    # autonumeric valuation
    valuation.autoNumeric({vMin: '0', vMax: '999999999999', mDec: '0'});
    valuation_value = valuation.autoNumericGet()
    valuation.autoNumericSet(amount_value) if valuation_value && valuation_value > 0

    # when company is changed, rebuilt investor options
    company.chosen().change =>

      # remove company from options
      newCompanyId = company.find(":selected").val()
      $('#deal_offerings_buyers option[value="Company:'+newCompanyId+'"]').remove()

      # add remaining
      # TODO add in correct order
      investorsCurrent = investors.find("option")
      investorsOriginal.each ->
        unless this in investorsCurrent || this.value is "Company:#{newCompanyId}"
          investors.append(this)
      investors.trigger("liszt:updated")

    # when cateorgy is changed, disable relevant fields
    category.change =>
      # enables fields passed in array, disables others
      # TODO: clear fields depending on whethen Create or Update
      enableFields = (enabled) ->
        fields = [investors, round, currency, amount, valuation]
        for field in fields
          if field in enabled
            field.removeAttr('disabled')
          else
            field.attr('disabled', 'disabled')

      category_value = category.val()
      switch category_value
        when 'raised funds from'
          enableFields [investors, round, currency, amount, valuation]
        when 'was acquired by'
          enableFields [investors, currency, amount, valuation]
        when 'incubated by', 'merged with'
          enableFields [investors]
        when 'shut down'
          enableFields []
      investors.trigger("liszt:updated")

    # when form is submitted
    amount.closest('form').submit ->

      # change amount value
      amount_value = amount.autoNumericGet()
      amount.val(amount_value) if amount_value && amount_value > 0

      # change valuation value
      valuation_value = valuation.autoNumericGet()
      valuation.val(valuation_value) if valuation_value && valuation_value > 0




