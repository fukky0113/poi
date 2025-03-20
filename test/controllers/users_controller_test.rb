require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
    @admin_user = users(:admin_user)
  end

  # test new
  test "should get new" do
    log_in_as(@user)
    get new_user_path
    assert_response :success
  end

  # test index
  test "should get index(admin)" do
    log_in_as(@admin_user)
    get users_path
    assert_response :success
  end

  test "should get index(no login)" do
    get users_path
    assert_response :see_other
    assert_redirected_to login_path
  end

  test "should get index" do
    log_in_as(@user)
    get users_path
    assert_response :see_other
    assert_redirected_to root_path
  end

  # test show
  test "should get show" do
    log_in_as(@user)
    get user_path(@user)
    assert_response :success
  end

  test "should get show(no login)" do
    get user_path(@user)
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test delete
  test "should delete user(admin)" do
    log_in_as(@admin_user)
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
    assert_response :see_other
  end

  test "should delete user(no login)" do
    assert_no_difference "User.count" do
      delete user_path(@admin_user)
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

  test "should delete user" do
    log_in_as(@user)
    assert_no_difference "User.count" do
      delete user_path(@admin_user)
    end
    assert_response :see_other
    assert_redirected_to root_path
  end

  # test create
  test "should create user" do
    assert_difference "User.count", +1 do
      post users_path, params: { user: { name: "test",
                                        email: "test@test.test",
                                        password: "password",
                                        password_confirmation: "password" } }
    end
    assert_response :see_other
  end
end
