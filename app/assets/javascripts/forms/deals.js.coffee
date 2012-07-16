jQuery ->
  if $('body.deals').length > 0
    $company = $('#deal_company_id')
    $category = $('#deal_category')
    $investors = $('#deal_offerings_buyers')
    $round = $('#deal_round')
    $currency = $('#deal_currency')
    $amount = $('#deal_amount')
    $valuation = $('#deal_pre_valuation')

    # store investors
    investorsOriginal = $investors.find("option")
    $investors.chosen()
    $company.chosen()

    # on load, remove company from options
    companyId = $company.find(":selected").val()
    $('#deal_offerings_buyers option[value="Company:'+companyId+'"]').remove()
    $investors.trigger("liszt:updated")

    # autonumeric amount
    $amount.autoNumeric({vMin: '0', vMax: '999999999999', mDec: '0'})
    amountValue = $amount.autoNumericGet() if $amount
    $amount.autoNumericSet(amount_value) if amountValue && amountValue > 0

    # autonumeric valuation
    $valuation.autoNumeric({vMin: '0', vMax: '999999999999', mDec: '0'});
    valuationValue = $valuation.autoNumericGet()
    $valuation.autoNumericSet(amount_value) if valuationValue && valuationValue > 0

    # when company is changed, rebuilt investor options
    $company.chosen().change =>

      # remove company from options
      newCompanyId = $company.find(":selected").val()
      $('#deal_offerings_buyers option[value="Company:'+newCompanyId+'"]').remove()

      # add remaining
      investorsOriginal.each ->
        this.remove
        unless this.value is "Company:#{newCompanyId}"
          $investors.append(this)
      $investors.trigger("liszt:updated")

    # when cateorgy is changed, disable relevant fields
    $category.change =>
      # enables fields passed in array, disables others
      # TODO: clear fields depending on whether Create or Update
      enableFields = (enabled) ->
        fields = [investors, round, currency, amount, valuation]
        for field in fields
          if field in enabled
            field.removeAttr('disabled')
          else
            field.attr('disabled', 'disabled')

      categoryValue = $category.val()
      switch categoryValue
        when 'raised funds from'
          enableFields [investors, round, currency, amount, valuation]
        when 'was acquired by'
          enableFields [investors, currency, amount, valuation]
        when 'incubated by', 'merged with'
          enableFields [investors]
        when 'shut down'
          enableFields []
      $investors.trigger("liszt:updated")

    # when form is submitted
    $amount.closest('form').submit ->
      # change amount value
      amountValue = $amount.autoNumericGet()
      $amount.val(amount_value) if amountValue && amountValue > 0

      # change valuation value
      valuationValue = $valuation.autoNumericGet()
      $valuation.val(valuation_value) if valuationValue && valuationValue > 0



