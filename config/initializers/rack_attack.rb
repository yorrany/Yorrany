class Rack::Attack
  # Rate limits

  # Limit all IPs to 300 requests per 5 minutes
  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  # Limit login attempts (Devise)
  throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
    if req.path == "/users/sign_in" && req.post?
      req.ip
    end
  end

  throttle("logins/email", limit: 5, period: 20.seconds) do |req|
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
    req.user_agent.to_s.match?(/Jorgee|python-requests|sqlmap|nikto|curl|wget/i) unless req.path.start_with?("/api")
  end
end
