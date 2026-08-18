# frozen_string_literal: true

require "test_helper"

class BlogControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = Post.find_or_create_by!(slug: "test-blog-post") do |p|
      p.published_at = Time.current
    end
    Mobility.with_locale(:"pt-PT") do
      @post.title = "Título em Português"
      @post.excerpt = "Resumo em Português"
      @post.content = "Conteúdo em Português"
    end
    Mobility.with_locale(:en) do
      @post.title = "Title in English"
      @post.excerpt = "Excerpt in English"
      @post.content = "Content in English"
    end
    @post.skip_auto_translate = true
    @post.save!
  end

  test "should get index in English" do
    get blog_index_url(locale: "en")
    assert_response :success
    assert_includes response.body, "Title in English"
  end

  test "should get index in Portuguese" do
    get blog_index_url(locale: "pt-PT")
    assert_response :success
    assert_includes response.body, "Título em Português"
  end

  test "should get show in English" do
    get blog_url(@post.slug, locale: "en")
    assert_response :success
    assert_includes response.body, "Title in English"
  end

  test "should get show in Portuguese" do
    get blog_url(@post.slug, locale: "pt-PT")
    assert_response :success
    assert_includes response.body, "Título em Português"
  end
end
