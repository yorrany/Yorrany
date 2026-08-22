# frozen_string_literal: true

module Admin
  class CaseStudiesController < ApplicationController
    before_action :set_case_study, only: %i[edit update destroy purge_attachment translate]

    def new
      @case_study = CaseStudy.new
    end

    def create
      @case_study = CaseStudy.new(case_study_params)
      if @case_study.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Estudo de caso criado e enfileirado para tradução." }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      params_to_update = case_study_params
      new_gallery = params_to_update.delete(:gallery_images)
      @case_study.gallery_images.attach(new_gallery) if new_gallery.present?

      if @case_study.update(params_to_update)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Estudo de caso atualizado e sincronizado." }
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

    def purge_attachment
      attachment = @case_study.gallery_images.attachments.find_by(id: params[:attachment_id])
      if attachment
        attachment.purge_later
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.remove("gallery_attachment_#{params[:attachment_id]}") }
          format.html { redirect_to edit_admin_case_study_path(@case_study), notice: "Imagem removida da galeria." }
        end
      else
        redirect_to edit_admin_case_study_path(@case_study), alert: "Imagem não encontrada."
      end
    end

    def translate
      AutoTranslateJob.perform_now(@case_study.class.name, @case_study.id, :'pt-PT')
      @case_study.reload
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("case_study_#{@case_study.id}", partial: "admin/case_studies/case_study", locals: { case_study: @case_study }) }
        format.html { redirect_to admin_path, notice: "Estudo de caso traduzido com sucesso." }
      end
    rescue StandardError => e
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("case_study_#{@case_study.id}", partial: "admin/case_studies/case_study", locals: { case_study: @case_study }) }
        format.html { redirect_to admin_path, alert: "Erro ao traduzir: #{e.message}" }
      end
    end

    private

    def set_case_study
      @case_study = CaseStudy.find(params[:id])
    end

    def case_study_params
      params.require(:case_study).permit(
        :title, :tagline, :client, :role, :period, :summary,
        :full_description, :challenge, :solution, :behavioral_insight,
        :tags, :is_spotlight, :accent_color, :image, gallery_images: []
      )
    end
  end
end
