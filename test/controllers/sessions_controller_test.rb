require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  # test new
  test "should get new" do
    get login_path
    assert_response :success
  end

  # test create
  test "should create session" do
    get login_path
    post login_path, params: { session: { email: "hogefuga@hogefuga.hogefuga",
                                          password: "password" } }
    assert_response :see_other
    assert_redirected_to root_path
  end

  test "should not create session (incorrect user)" do
    get login_path
    post login_path, params: { session: { email: "incorrect@hogefuga.hogefuga",
                                          password: "password" } }
    assert_response :unprocessable_entity
    assert_template "sessions/new"
  end

  test "should not create session (already log in)" do
    log_in_as(@user)
    post login_path, params: { session: { email: "hogefuga@hogefuga.hogefuga",
                                          password: "password" } }
    assert_response :see_other
    assert_redirected_to root_path
  end

  # test destroy
  test "should destroy session" do
    log_in_as(@user)
    delete logout_path(@user)
    assert_response :see_other
    assert_redirected_to root_url
  end
end
