module Admin
  class DashboardController < ApplicationController
    def index
      @case_studies = CaseStudy.all.order(created_at: :desc)
      @experience_items = ExperienceItem.all.order(created_at: :desc)
      @certifications = Certification.all
      @academic_backgrounds = AcademicBackground.all.order(created_at: :desc)
    end
  end
end
