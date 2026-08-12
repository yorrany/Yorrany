require "net/http"
require "uri"
require "json"

class GithubContributionsService
  TOKEN = ENV.fetch("GITHUB_TOKEN", "")

  def self.fetch_calendar
    Rails.cache.fetch("github_contributions_yorrany", expires_in: 6.hours) do
      uri = URI("https://api.github.com/graphql")
      req = Net::HTTP::Post.new(uri)
      req["Authorization"] = "Bearer #{TOKEN}"
      req.body = {
        query: "query { viewer { contributionsCollection { contributionCalendar { totalContributions weeks { contributionDays { contributionCount date color } } } } } }"
      }.to_json

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

      data = JSON.parse(res.body)
      data.dig("data", "viewer", "contributionsCollection", "contributionCalendar")
    end
  rescue StandardError => e
    Rails.logger.error "GitHub API Error: #{e.message}"
    nil
  end
end
