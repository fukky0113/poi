require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
    @categories = categories(:category)
    @post = posts(:post)
    @post.category_id = @categories.id
    @post.user_id = @user.id
    @post.save
  end

  # test new
  test "should get new" do
    log_in_as(@user)
    get new_user_post_path(@user)
    assert_response :success
  end

  test "should not get new (not log in)" do
    get new_user_post_path(@user)
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test show
  test "should get show" do
    log_in_as(@user)
    get user_post_path(user_id: @user.id, id: @post.id)
    assert_response :success
  end

  test "should not get show (not log in)" do
    get user_post_path(user_id: @user.id, id: @post.id)
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test index
  test "should get index" do
    log_in_as(@user)
    get user_posts_path(@user)
    assert_response :success
  end

  test "should not get index (not log in)" do
    get user_posts_path(@user)
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test delete
  test "Redirect at destroy time" do
    log_in_as(@user)
    assert_difference "Post.count", -1 do
      delete user_post_path(user_id: @user.id, id: @post.id), headers: { "HTTP_REFERER" => root_path }
    end
    assert_response :see_other
  end

  test "should not delete (not log in)" do
    assert_no_difference "Post.count" do
      delete user_post_path(user_id: @user.id, id: @post.id), headers: { "HTTP_REFERER" => root_path }
    end
    assert_response :see_other
    assert_redirected_to login_path
  end
end
