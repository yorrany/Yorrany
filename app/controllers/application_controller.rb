class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_locale

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def set_locale
    raw_locale = params[:locale].to_s.strip.downcase
    I18n.locale = if raw_locale.start_with?("pt")
                    :"pt-PT"
    elsif raw_locale.start_with?("es")
                    :es
    elsif raw_locale.start_with?("en")
                    :en
    elsif I18n.available_locales.include?(raw_locale.to_sym)
                    raw_locale.to_sym
    else
                    I18n.default_locale
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
