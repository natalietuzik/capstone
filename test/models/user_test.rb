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

  test "remember sets remember_digest" do
    @user.save
    assert_nil @user.remember_digest
    @user.remember
    assert_not_nil @user.remember_digest
    assert_not_nil @user.remember_token
  end

  test "authenticated? returns true for valid token" do
    @user.save
    @user.remember
    assert @user.authenticated?(@user.remember_token)
  end

  test "authenticated? returns false for wrong token" do
    @user.save
    @user.remember
    assert_not @user.authenticated?("wrongtoken")
  end

  test "authenticated? returns false when digest is nil" do
    @user.save
    assert_not @user.authenticated?("anytoken")
  end

  test "forget clears remember_digest" do
    @user.save
    @user.remember
    @user.forget
    assert_nil @user.reload.remember_digest
  end
end
