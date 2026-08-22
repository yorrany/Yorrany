# frozen_string_literal: true

module AutoTranslatable
  extend ActiveSupport::Concern

  included do
    attr_accessor :skip_auto_translate, :source_locale_for_translation
    after_commit :enqueue_auto_translate_job, on: %i[create update], unless: :skip_auto_translate
  end

  def translate_now!(source_locale = :'pt-PT')
    AutoTranslateJob.new.perform(self.class.name, self.id, source_locale)
    self.reload
  end

  def translation_status
    attrs = self.class.try(:mobility_attributes) || []
    return {} if attrs.empty?

    I18n.available_locales.each_with_object({}) do |loc, status|
      has_val = attrs.any? do |attr|
        val = begin
          self.public_send(attr, locale: loc, fallback: false)
        rescue ArgumentError
          Mobility.with_locale(loc) { self.public_send(attr) }
        end
        val.present?
      end
      status[loc] = has_val
    end
  end

  def missing_translation_locales
    translation_status.select { |_loc, translated| !translated }.keys
  end

  private

  def enqueue_auto_translate_job
    src_locale = source_locale_for_translation.presence || I18n.locale.presence || :'pt-PT'
    AutoTranslateJob.perform_later(self.class.name, self.id, src_locale)
  end
end
