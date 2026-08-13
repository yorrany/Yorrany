class HomeController < ApplicationController
  def index
    @case_studies = CaseStudy.all
    @experiences = ExperienceItem.order(created_at: :desc)
    @certifications = Certification.all
    @academic_bgs = AcademicBackground.order(created_at: :desc)
    @github_calendar = GithubContributionsService.fetch_calendar
    @posts = Post.where('published_at <= ?', Time.current).order(published_at: :desc).limit(2)
    @skills = SoftwareSkill.all
    @pillars = ExpertisePillar.all
  end

  def llms
    @case_studies = CaseStudy.all
    @experiences = ExperienceItem.order(created_at: :desc)
    @certifications = Certification.order(year: :desc)
    @academic_bgs = AcademicBackground.order(created_at: :desc)

    render "llms", layout: false, content_type: "text/plain"
  end

  def privacy
  end
end
