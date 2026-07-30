require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "現在のパスワードが間違っている場合、エラーメッセージを表示する" do
    user = users(:one)

    sign_in user

    patch update_account_password_path, params: {
      user: {
        current_password: "wrong_password",
        password: "new_password123",
        password_confirmation: "new_password123"
      }
    }

    assert_response :unprocessable_entity
    assert_includes response.body, "現在のパスワードが正しくありません"
  end
end
