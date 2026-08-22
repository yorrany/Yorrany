# frozen_string_literal: true

module Admin
  class AcademicBackgroundsController < ApplicationController
    before_action :set_academic_background, only: %i[edit update destroy translate]

    def new
      @academic_background = AcademicBackground.new
    end

    def create
      @academic_background = AcademicBackground.new(academic_background_params)
      if @academic_background.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Formação acadêmica criada e enfileirada para tradução." }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @academic_background.update(academic_background_params)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Formação acadêmica atualizada e sincronizada." }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @academic_background.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_path, notice: "Formação acadêmica removida." }
      end
    end

    def translate
      AutoTranslateJob.perform_now(@academic_background.class.name, @academic_background.id, :'pt-PT')
      @academic_background.reload
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("academic_background_#{@academic_background.id}", partial: "admin/academic_backgrounds/academic_background", locals: { academic_background: @academic_background }) }
        format.html { redirect_to admin_path, notice: "Formação acadêmica traduzida com sucesso." }
      end
    rescue StandardError => e
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("academic_background_#{@academic_background.id}", partial: "admin/academic_backgrounds/academic_background", locals: { academic_background: @academic_background }) }
        format.html { redirect_to admin_path, alert: "Erro ao traduzir: #{e.message}" }
      end
    end

    private

    def set_academic_background
      @academic_background = AcademicBackground.find(params[:id])
    end

    def academic_background_params
      params.require(:academic_background).permit(
        :degree, :institution, :period, :field_of_study,
        :thesis, :research_focus, :image, :certificate
      )
    end
  end
end
