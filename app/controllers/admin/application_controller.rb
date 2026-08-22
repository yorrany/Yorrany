# frozen_string_literal: true

module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!
    before_action :set_admin_locale
    layout "admin"

    private

    def set_admin_locale
      I18n.locale = if params[:locale].present? && I18n.available_locales.include?(params[:locale].to_sym)
                      params[:locale].to_sym
      else
                      :'pt-PT'
      end
    end
  end
end
