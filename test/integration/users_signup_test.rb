require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  test "invalid signup information" do
    log_in_as(@user)
    get new_user_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_redirected_to root_path
  end

  test "valid signup information" do
    log_in_as(@user)
    assert_no_difference "User.count" do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    assert_redirected_to root_path
  end
end
