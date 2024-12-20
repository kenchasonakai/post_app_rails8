require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    user = User.new(email: "test@example.com", password: "password", nickname: "testuser", password_confirmation: "password")
    assert user.valid?
  end

  test "should be invalid without a nickname" do
    user = User.new(email: "test@example.com", password: "password", nickname: "", password_confirmation: "password")
    assert_not user.valid?
    assert_includes user.errors.details[:nickname], { error: :blank }
  end

  test "should be invalid with a nickname longer than 50 characters" do
    user = User.new(email: "test@example.com", password: "password", nickname: "a" * 51, password_confirmation: "password")
    assert_not user.valid?
    assert_includes user.errors.details[:nickname], { error: :too_long, count: 50 }
  end

  test "should be invalid without an email" do
    user = User.new(email: "", password: "password", nickname: "testuser", password_confirmation: "password")
    assert_not user.valid?
    assert_includes user.errors.details[:email], { error: :blank }
  end

  test "should be invalid without a password" do
    user = User.new(email: "test@example.com", password: "", nickname: "testuser", password_confirmation: "password")
    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :too_short, count: 3 }
  end
end
