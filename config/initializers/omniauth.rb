Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'EWLi0cRzmGGF9kzJdVAJ3w', 'AZwBIOVvxsAzkhonBIB7aE5NzITQTCozvi33DjcaI'
  provider :linkedin, '4h7odlmlcsi3', 'HCmhbtXLBchaJIez'
  
end