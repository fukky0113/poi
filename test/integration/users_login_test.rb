require "test_helper"

class UsersLogin < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end
end

class InvalidPasswordTest < UsersLogin
  test "login path" do
    get login_path
    assert_template "sessions/new"
  end

  test "login with valid email/invalid password" do
    post login_path, params: {session: {email: "", password: ""}}
    assert_not is_logged_in?
    assert_response :unprocessable_entity
    assert_template "sessions/new"
    get root_path
  end
end

class ValidLogin < UsersLogin
  def setup
    super
    post login_path, params: {session: {email: @user.email, password: 'password' } }
  end
end

class ValidLoginTest < ValidLogin
  test "valid login" do
    assert is_logged_in? 
    assert_redirected_to @user
  end
end

class Logout < ValidLogin
  def setup
    super
    delete logout_path
  end
end

class LogoutTest < Logout
  test "successful logout" do
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "should still work after logout in second window" do
    delete logout_path
    assert_redirected_to root_url
  end

  class RememberingTest < UsersLogin
    test "login with remembering" do
      log_in_as(@user, remember_me: "1")
      assert_not cookies[:remember_token].blank?
    end
  end
end