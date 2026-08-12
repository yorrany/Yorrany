module Admin
  class CertificationsController < ApplicationController
    before_action :set_certification, only: %i[edit update destroy]

    def new
      @certification = Certification.new
    end

    def create
      @certification = Certification.new(certification_params)
      if @certification.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Certificação criada." }
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
          format.html { redirect_to admin_path, notice: "Certificação atualizada." }
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

    private

    def set_certification
      @certification = Certification.find(params[:id])
    end

    def certification_params
      params.require(:certification).permit(
        :title, :issuer, :category, :description, :image,
        :skills, :credential_code, :credential_url, :document_title, :document_caption
      )
    end
  end
end
