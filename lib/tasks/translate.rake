# frozen_string_literal: true

namespace :translate do
  def translatable_models
    [
      CaseStudy,
      ExperienceItem,
      Certification,
      AcademicBackground,
      ExpertisePillar,
      Post
    ]
  end

  desc "Translate all translatable content across the site using Gemini AI"
  task all: :environment do
    puts "== Starting Full Content Translation =="
    translatable_models.each do |model_class|
      count = model_class.count
      puts "\nProcessing #{model_class.name} (#{count} records)..."
      model_class.find_each.with_index(1) do |record, idx|
        print "  [#{idx}/#{count}] Translating #{model_class.name}##{record.id}... "
        record.translate_now!(:'pt-PT')
        puts "Done (Status: #{record.translation_status.inspect})"
      end
    end
    puts "\n== Full Translation Completed! =="
  end

  desc "Translate only records with missing translations"
  task missing: :environment do
    puts "== Translating Missing Content =="
    total_translated = 0
    translatable_models.each do |model_class|
      model_class.find_each do |record|
        missing = record.missing_translation_locales
        if missing.any?
          print "Translating #{model_class.name}##{record.id} (Missing: #{missing.join(', ')})... "
          record.translate_now!(:'pt-PT')
          total_translated += 1
          puts "Done."
        end
      end
    end
    puts "\nDone. #{total_translated} records updated."
  end

  desc "Show translation status report for all translatable content"
  task status: :environment do
    puts "\n================ TRANSLATION STATUS REPORT ================"
    locales = I18n.available_locales

    translatable_models.each do |model_class|
      total = model_class.count
      puts "\n#{model_class.name} (Total: #{total}):"
      locales.each do |loc|
        translated = model_class.all.count do |r|
          r.class.mobility_attributes.any? do |attr|
            Mobility.with_locale(loc) { r.public_send(attr).present? }
          end
        end
        pct = total > 0 ? ((translated.to_f / total) * 100).round(1) : 100.0
        puts "  - #{loc}: #{translated}/#{total} (#{pct}%)"
      end
    end
    puts "\n==========================================================\n"
  end
end
