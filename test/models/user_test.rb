require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "有効なユーザーを作成できる" do
    user = User.new(
      name: "テストユーザー",
      email: "test@example.com",
      password: "password123"
    )

    assert user.valid?
  end

  test "メールアドレスがない場合は無効になる" do
    user = User.new(
      name: "テストユーザー",
      password: "password123"
    )

    assert_not user.valid?
    assert_includes user.errors[:email], "を入力してください"
  end

  test "メールアドレスが重複している場合は無効になる" do
    existing_user = users(:one)

    user = User.new(
      name: "テストユーザー",
      email: existing_user.email,
      password: "password123"
    )

    assert_not user.valid?
    assert_includes user.errors[:email], "はすでに使用されています"
  end
end
