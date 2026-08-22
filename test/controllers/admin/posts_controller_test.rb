# frozen_string_literal: true

require "test_helper"

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @post = posts(:one)
  end

  test "should get new" do
    get new_admin_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post admin_posts_url, params: {
        post: {
          title: "Novo Artigo no Blog",
          slug: "novo-artigo-no-blog",
          excerpt: "Um resumo do artigo",
          content: "Conteúdo completo aqui...",
          published_at: Time.current
        }
      }
    end

    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should update post" do
    patch admin_post_url(@post), params: {
      post: {
        title: "Artigo Atualizado"
      }
    }
    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should translate post" do
    with_stubbed_translation({ "title" => "Translated Blog Post" }) do
      post translate_admin_post_url(@post)
      assert_redirected_to admin_path(locale: :'pt-PT')
    end
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete admin_post_url(@post)
    end
    assert_redirected_to admin_path(locale: :'pt-PT')
  end
end
