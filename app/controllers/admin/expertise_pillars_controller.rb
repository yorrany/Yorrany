# frozen_string_literal: true

module Admin
  class ExpertisePillarsController < ApplicationController
    before_action :set_expertise_pillar, only: %i[edit update destroy translate]

    def new
      @expertise_pillar = ExpertisePillar.new
    end

    def create
      @expertise_pillar = ExpertisePillar.new(expertise_pillar_params)
      if @expertise_pillar.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Pilar de atuação criado e enfileirado para tradução." }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @expertise_pillar.update(expertise_pillar_params)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Pilar de atuação atualizado e sincronizado." }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @expertise_pillar.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_path, notice: "Pilar de atuação removido." }
      end
    end

    def reorder
      if params[:ordered_ids].present?
        ExpertisePillar.transaction do
          params[:ordered_ids].each_with_index do |id, index|
            ExpertisePillar.where(id: id).update_all(position: index + 1)
          end
        end
      end
      head :ok
    end

    def translate
      AutoTranslateJob.perform_now(@expertise_pillar.class.name, @expertise_pillar.id, :'pt-PT')
      @expertise_pillar.reload
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("expertise_pillar_#{@expertise_pillar.id}", partial: "admin/expertise_pillars/expertise_pillar", locals: { expertise_pillar: @expertise_pillar }) }
        format.html { redirect_to admin_path, notice: "Pilar traduzido com sucesso." }
      end
    rescue StandardError => e
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("expertise_pillar_#{@expertise_pillar.id}", partial: "admin/expertise_pillars/expertise_pillar", locals: { expertise_pillar: @expertise_pillar }) }
        format.html { redirect_to admin_path, alert: "Erro ao traduzir: #{e.message}" }
      end
    end

    private

    def set_expertise_pillar
      @expertise_pillar = ExpertisePillar.find(params[:id])
    end

    def expertise_pillar_params
      params.require(:expertise_pillar).permit(:title, :description, :position, :image)
    end
  end
end
