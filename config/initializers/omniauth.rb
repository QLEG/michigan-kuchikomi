
Rails.application.config.middleware.use OmniAuth::Builder do
provider :twitter, Rails.application.credentials.twitter[:TWITTER_KEY], Rails.application.credentials.twitter[:TWITTER_SECRET]
end
