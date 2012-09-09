Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, '4h7odlmlcsi3', 'HCmhbtXLBchaJIez'
  provider :twitter, 'Z61i6268bRaxgJlWHyDnw', 'kQDI1aerhQaqqZyaxcFMUXoRbeN4RqAeWCjmLwRA'
end