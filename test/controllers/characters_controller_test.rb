require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  test "should get select" do
    get characters_select_url
    assert_response :success
  end

  test "should get show" do
    get characters_show_url
    assert_response :success
  end
end
