require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "test@example.com", password: "password123", password_confirmation: "password123")
  end

  test "valid user" do
    assert @user.valid?
  end

  test "email must be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "email must be unique" do
    @user.save
    duplicate = User.new(email: "test@example.com", password: "password123")
    assert_not duplicate.valid?
  end

  test "email uniqueness is case insensitive" do
    @user.save
    duplicate = User.new(email: "TEST@EXAMPLE.COM", password: "password123")
    assert_not duplicate.valid?
  end

  test "password must be at least 6 characters" do
    @user.password = "abc"
    @user.password_confirmation = "abc"
    assert_not @user.valid?
  end

  test "has secure password" do
    @user.save
    assert @user.authenticate("password123")
    assert_not @user.authenticate("wrong")
  end
end
