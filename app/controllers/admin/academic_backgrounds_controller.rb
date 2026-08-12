module Admin
  class AcademicBackgroundsController < ApplicationController
    before_action :set_academic_background, only: %i[edit update destroy]

    def new
      @academic_background = AcademicBackground.new
    end

    def create
      @academic_background = AcademicBackground.new(academic_background_params)
      if @academic_background.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Formação criada." }
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
          format.html { redirect_to admin_path, notice: "Formação atualizada." }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @academic_background.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_path, notice: "Formação removida." }
      end
    end

    private

    def set_academic_background
      @academic_background = AcademicBackground.find(params[:id])
    end

    def academic_background_params
      params.require(:academic_background).permit(:degree, :institution, :period, :field_of_study, :thesis, :research_focus, :image, :certificate)
    end
  end
end
