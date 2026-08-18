class Rack::Attack
  # Safelist local requests
  safelist("allow from localhost") do |req|
    req.ip == "127.0.0.1" || req.ip == "::1"
  end

  # Safelist Active Storage, assets and health check from general throttling
  safelist("allow static assets") do |req|
    req.path.start_with?("/rails/active_storage") ||
      req.path.start_with?("/assets") ||
      req.path == "/up"
  end

  # Rate limits for public routes
  # Limit public requests to 1000 per 5 minutes
  throttle("req/ip", limit: 1000, period: 5.minutes) do |req|
    req.ip
  end

  # Limit login attempts (Devise)
  throttle("logins/ip", limit: 20, period: 1.minute) do |req|
    if req.path == "/users/sign_in" && req.post?
      req.ip
    end
  end

  throttle("logins/email", limit: 10, period: 1.minute) do |req|
    if req.path == "/users/sign_in" && req.post?
      req.params["user"]["email"].to_s.downcase.gsub(/\s+/, "").presence rescue nil
    end
  end

  # Limit contact form submissions
  throttle("contact/ip", limit: 10, period: 1.minute) do |req|
    if req.path == "/contact" && req.post?
      req.ip
    end
  end

  # Block known bad bots/scanners
  blocklist("block malicious bots") do |req|
    # commonly abused user agents
    req.user_agent.to_s.match?(/Jorgee|python-requests|sqlmap|nikto/i)
  end
end
