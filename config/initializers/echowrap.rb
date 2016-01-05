Echowrap.configure do |config|
  config.api_key =       Rails.application.secrets.echonest_api_key
  config.consumer_key =  Rails.application.secrets.echonest_consumer_key
  config.shared_secret = Rails.application.secrets.echonest_shared_secret
end
