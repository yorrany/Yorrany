class BlogController < ApplicationController
  def index
    @posts = Post.where("published_at <= ?", Time.current).order(published_at: :desc)
  end

  def show
    @post = Post.find_by!(slug: params[:id])
  end
end
