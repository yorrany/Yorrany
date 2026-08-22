# frozen_string_literal: true

require "test_helper"

class Admin::ExpertisePillarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @expertise_pillar = expertise_pillars(:one)
  end

  test "should get new" do
    get new_admin_expertise_pillar_url
    assert_response :success
  end

  test "should create expertise_pillar" do
    assert_difference("ExpertisePillar.count") do
      post admin_expertise_pillars_url, params: {
        expertise_pillar: {
          title: "Sistemas Visuais",
          description: "Design systems e tokens",
          position: 1
        }
      }
    end

    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should update expertise_pillar" do
    patch admin_expertise_pillar_url(@expertise_pillar), params: {
      expertise_pillar: {
        title: "Título Atualizado"
      }
    }
    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should translate expertise_pillar" do
    with_stubbed_translation({ "title" => "Visual Systems" }) do
      post translate_admin_expertise_pillar_url(@expertise_pillar)
      assert_redirected_to admin_path(locale: :'pt-PT')
    end
  end

  test "should destroy expertise_pillar" do
    assert_difference("ExpertisePillar.count", -1) do
      delete admin_expertise_pillar_url(@expertise_pillar)
    end
    assert_redirected_to admin_path(locale: :'pt-PT')
  end
end
