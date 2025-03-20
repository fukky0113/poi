require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be valid" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be valid" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "password should be valid" do
    @user.password = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "z" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.name = "z" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplication_user = @user.dup
    @user.save
    assert_not duplication_user.valid?
  end
end
