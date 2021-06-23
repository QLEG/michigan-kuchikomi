Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter ,Rails.application.credentials.dig(twitter, ENV['TWITTER_KEY']), Rails.application.credentials.dig(ENV['TWITTER_SECRET'])
end
