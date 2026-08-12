module Admin
  class ExperienceItemsController < ApplicationController
    before_action :set_experience_item, only: %i[edit update destroy]

    def new
      @experience_item = ExperienceItem.new
    end

    def create
      @experience_item = ExperienceItem.new(experience_item_params)
      if @experience_item.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Experiência criada." }
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
          format.html { redirect_to admin_path, notice: "Experiência atualizada." }
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

    private

    def set_experience_item
      @experience_item = ExperienceItem.find(params[:id])
    end

    def experience_item_params
      params.require(:experience_item).permit(:role, :company, :type_name, :summary, :highlights, :skills, :image)
    end
  end
end
