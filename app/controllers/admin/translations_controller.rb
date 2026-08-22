# frozen_string_literal: true

module Admin
  class TranslationsController < ApplicationController
    TRANSLATABLE_MODELS = [
      CaseStudy,
      ExperienceItem,
      Certification,
      AcademicBackground,
      ExpertisePillar,
      Post
    ].freeze

    def create
      scope = params[:scope] || "missing"
      queued_count = 0

      TRANSLATABLE_MODELS.each do |model_class|
        model_class.find_each do |record|
          if scope == "all" || record.missing_translation_locales.any?
            AutoTranslateJob.perform_later(record.class.name, record.id, :'pt-PT')
            queued_count += 1
          end
        end
      end

      redirect_to admin_path, notice: "#{queued_count} itens foram enfileirados para tradução automática em segundo plano."
    end
  end
end
