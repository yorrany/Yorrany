module Admin
  class CaseStudiesController < ApplicationController
    before_action :set_case_study, only: %i[edit update destroy]

    def new
      @case_study = CaseStudy.new
    end

    def create
      @case_study = CaseStudy.new(case_study_params)
      if @case_study.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Estudo de caso criado." }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @case_study.update(case_study_params)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Estudo de caso atualizado." }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @case_study.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_path, notice: "Estudo de caso removido." }
      end
    end

    private

    def set_case_study
      @case_study = CaseStudy.find(params[:id])
    end

    def case_study_params
      params.require(:case_study).permit(:title, :tagline, :client, :role, :period, :summary, :full_description, :challenge, :solution, :behavioral_insight, :tags, :is_spotlight, :accent_color, :image, gallery_images: [])
    end
  end
end
