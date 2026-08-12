class LinkedinAuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :callback

  def callback
    auth = request.env["omniauth.auth"]
    @name = auth.info.name
    @email = auth.info.email

    render layout: false
  end

  def failure
    render plain: "Authentication failed. Please try again.", status: :unauthorized
  end
end
