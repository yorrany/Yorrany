class Users::SessionsController < Devise::SessionsController
  prepend_before_action :verify_turnstile, only: [ :create ]

  private

  def verify_turnstile
    require "net/http"
    require "uri"
    require "json"

    token = params["cf-turnstile-response"]
    client_ip = request.remote_ip

    begin
      uri = URI.parse("https://challenges.cloudflare.com/turnstile/v0/siteverify")
      response = Net::HTTP.post_form(uri, {
        "secret" => ENV["TURNSTILE_SECRET"],
        "response" => token,
        "remoteip" => client_ip
      })
      result = JSON.parse(response.body)
      Rails.logger.info("[TURNSTILE] Verify Response: #{result.inspect}")
      Rails.logger.info("[TURNSTILE] Secret Present? #{ENV['TURNSTILE_SECRET'].present?} | Token: #{token.present?}")
    rescue StandardError => e
      Rails.logger.error("[TURNSTILE] Error: #{e.message}")
      result = {}
    end

    unless result["success"]
      flash[:alert] = "Falha na verificação de segurança: #{result['error-codes']&.join(', ')}. Por favor, tente novamente."
      redirect_to new_user_session_path
    end
  end
end
