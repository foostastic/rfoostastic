Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  limit_domains = ENV["GOOGLE_LIMIT_DOMAINS"] || false
  google_options = {}
  google_options[:hd] = limit_domains.split(" ") if limit_domains
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], google_options
end
