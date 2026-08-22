# frozen_string_literal: true

module Admin
  class PostsController < ApplicationController
    before_action :set_post, only: %i[edit update destroy translate]

    def new
      @post = Post.new(published_at: Time.current)
    end

    def create
      @post = Post.new(post_params)
      if @post.slug.blank? && @post.title.present?
        @post.slug = @post.title.parameterize
      end

      if @post.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Artigo criado e enfileirado para tradução." }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @post.update(post_params)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_path, notice: "Artigo atualizado e sincronizado." }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_path, notice: "Artigo removido." }
      end
    end

    def translate
      AutoTranslateJob.perform_now(@post.class.name, @post.id, :'pt-PT')
      @post.reload
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("post_#{@post.id}", partial: "admin/posts/post", locals: { post: @post }) }
        format.html { redirect_to admin_path, notice: "Artigo traduzido com sucesso." }
      end
    rescue StandardError => e
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("post_#{@post.id}", partial: "admin/posts/post", locals: { post: @post }) }
        format.html { redirect_to admin_path, alert: "Erro ao traduzir: #{e.message}" }
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :slug, :excerpt, :content, :published_at, :cover_image)
    end
  end
end
