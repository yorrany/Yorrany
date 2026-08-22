# frozen_string_literal: true

module Admin
  class ExperienceItemsController < ApplicationController
    before_action :set_experience_item, only: %i[edit update destroy translate]

    def new
      @experience_item = ExperienceItem.new
    end

    def create
      @experience_item = ExperienceItem.new(experience_item_params)
      if @experience_item.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Experiência criada e enfileirada para tradução." }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @experience_item.update(experience_item_params)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Experiência atualizada e sincronizada." }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @experience_item.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_path, notice: "Experiência removida." }
      end
    end

    def translate
      AutoTranslateJob.perform_now(@experience_item.class.name, @experience_item.id, :'pt-PT')
      @experience_item.reload
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("experience_item_#{@experience_item.id}", partial: "admin/experience_items/experience_item", locals: { experience_item: @experience_item }) }
        format.html { redirect_to admin_path, notice: "Experiência traduzida com sucesso." }
      end
    rescue StandardError => e
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("experience_item_#{@experience_item.id}", partial: "admin/experience_items/experience_item", locals: { experience_item: @experience_item }) }
        format.html { redirect_to admin_path, alert: "Erro ao traduzir: #{e.message}" }
      end
    end

    private

    def set_experience_item
      @experience_item = ExperienceItem.find(params[:id])
    end

    def experience_item_params
      params.require(:experience_item).permit(
        :role, :company, :type_name, :location, :period,
        :summary, :highlights, :skills, :image
      )
    end
  end
end
