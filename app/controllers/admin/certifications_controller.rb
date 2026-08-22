# frozen_string_literal: true

module Admin
  class CertificationsController < ApplicationController
    before_action :set_certification, only: %i[edit update destroy translate]

    def new
      @certification = Certification.new
    end

    def create
      @certification = Certification.new(certification_params)
      if @certification.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Certificação criada e enfileirada para tradução." }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @certification.update(certification_params)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Certificação atualizada e sincronizada." }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @certification.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_path, notice: "Certificação removida." }
      end
    end

    def reorder
      if params[:ordered_ids].present?
        Certification.transaction do
          params[:ordered_ids].each_with_index do |id, index|
            Certification.where(id: id).update_all(position: index + 1)
          end
        end
      end
      head :ok
    end

    def translate
      AutoTranslateJob.perform_now(@certification.class.name, @certification.id, :'pt-PT')
      @certification.reload
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("certification_#{@certification.id}", partial: "admin/certifications/certification", locals: { certification: @certification }) }
        format.html { redirect_to admin_path, notice: "Certificação traduzida com sucesso." }
      end
    rescue StandardError => e
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("certification_#{@certification.id}", partial: "admin/certifications/certification", locals: { certification: @certification }) }
        format.html { redirect_to admin_path, alert: "Erro ao traduzir: #{e.message}" }
      end
    end

    private

    def set_certification
      @certification = Certification.find(params[:id])
    end

    def certification_params
      params.require(:certification).permit(
        :title, :issuer, :category, :description, :image,
        :skills, :badge_code, :year, :credential_code, :credential_url,
        :document_title, :document_caption
      )
    end
  end
end
