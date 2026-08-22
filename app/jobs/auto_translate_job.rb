# frozen_string_literal: true

class AutoTranslateJob < ApplicationJob
  queue_as :default

  def perform(class_name, record_id, source_locale = :'pt-PT')
    record = class_name.safe_constantize&.find_by(id: record_id)
    return unless record

    translated_attrs = record.class.try(:mobility_attributes) || []
    return if translated_attrs.empty?

    source_sym = source_locale.to_sym
    to_translate = {}

    # Read attributes from the specified source locale
    Mobility.with_locale(source_sym) do
      translated_attrs.each do |attr|
        val = record.public_send(attr)
        to_translate[attr.to_s] = val if val.present?
      end
    end

    # Fallback: If specified source locale is empty, inspect other available locales
    if to_translate.empty?
      (I18n.available_locales - [ source_sym ]).each do |alt_locale|
        Mobility.with_locale(alt_locale) do
          translated_attrs.each do |attr|
            val = record.public_send(attr)
            to_translate[attr.to_s] = val if val.present?
          end
        end
        if to_translate.present?
          source_sym = alt_locale
          break
        end
      end
    end

    return if to_translate.empty?

    target_locales = I18n.available_locales - [ source_sym ]
    any_updated = false

    target_locales.each do |target_locale|
      res = TranslationService.translate_attributes(to_translate, from: source_sym, to: target_locale)
      if res.success? && res.translations.present?
        Mobility.with_locale(target_locale) do
          res.translations.each do |attr_name, translated_val|
            if record.respond_to?("#{attr_name}=")
              record.public_send("#{attr_name}=", translated_val)
            end
          end
        end
        any_updated = true
      else
        Rails.logger.warn "[AutoTranslateJob] Translation from #{source_sym} to #{target_locale} for #{class_name}##{record_id} failed: #{res.error}"
      end
    end

    if any_updated
      record.skip_auto_translate = true
      record.save(validate: false)
      Rails.logger.info "[AutoTranslateJob] Successfully translated #{class_name}##{record_id} to #{target_locales.join(', ')}"
    end
  rescue StandardError => e
    Rails.logger.error "[AutoTranslateJob] Error translating #{class_name}##{record_id}: #{e.class} - #{e.message}\n#{e.backtrace.first(5).join("\n")}"
  end
end
