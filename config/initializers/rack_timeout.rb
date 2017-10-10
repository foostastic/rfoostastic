Rack::Timeout.service_timeout = (ENV["SERVICE_TIMEOUT"] && ENV["SERVICE_TIMEOUT"].to_i) || 5 # seconds
