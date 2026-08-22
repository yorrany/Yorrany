# frozen_string_literal: true

module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!
    before_action :set_admin_locale
    layout "admin"

    private

    def set_admin_locale
      I18n.locale = :'pt-PT'
    end
  end
end
