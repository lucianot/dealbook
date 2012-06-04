  # Options
  COMPANY_STATUSES = %w[active inactive acquired merged]  
  INVESTOR_STATUSES = %w[active inactive acquired merged]
  INVESTOR_CATEGORIES = %w[angel VC accelerator incubator corporate]    
  INVESTOR_STAGES = ['Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']  
  DEAL_CATEGORIES = ['financing round', 'acquisition', 'merger']
  DEAL_ROUNDS = ['Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']

  # Regex
  URL_REGEX = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  LINKEDIN_COMPANY_REGEX = /^(http|https):\/\/[a-z0-9]+\.linkedin\.com\/company\/[0-9]+.*$/ix
  LINKEDIN_REGEX = /^(http|https):\/\/[a-z0-9]+\.linkedin\.com\/(profile\/view\?id=|company\/)?[0-9]+.*$/ix