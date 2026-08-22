# frozen_string_literal: true

require "test_helper"

class Admin::ExperienceItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @experience_item = experience_items(:one)
  end

  test "should get new" do
    get new_admin_experience_item_url
    assert_response :success
  end

  test "should create experience_item" do
    assert_difference("ExperienceItem.count") do
      post admin_experience_items_url, params: {
        experience_item: {
          role: "Senior Product Designer",
          company: "Acme Corp",
          type_name: "Full-Time",
          location: "Remoto",
          period: "2023 - Presente",
          summary: "Liderança de Design System",
          highlights: "Tokenização || Acessibilidade",
          skills: "Figma, Rails, React"
        }
      }
    end

    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should update experience_item" do
    patch admin_experience_item_url(@experience_item), params: {
      experience_item: {
        role: "Lead Designer"
      }
    }
    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should translate experience_item" do
    with_stubbed_translation({ "role" => "Lead Designer" }) do
      post translate_admin_experience_item_url(@experience_item)
      assert_redirected_to admin_path(locale: :'pt-PT')
    end
  end

  test "should destroy experience_item" do
    assert_difference("ExperienceItem.count", -1) do
      delete admin_experience_item_url(@experience_item)
    end
    assert_redirected_to admin_path(locale: :'pt-PT')
  end
end
