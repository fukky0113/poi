require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
    @category = categories(:category)
    @post = Post.new(user_id: @user.id, description: "Example Description", category_id: @category.id, latitude: 36, longitude: 136, point: "群馬県")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user_id should be valid" do
    @post.user_id = " "
    assert_not @post.valid?
  end

  test "category_id should be valid" do
    @post.category_id = " "
    assert_not @post.valid?
  end

  test "latitude should be valid" do
    @post.latitude = " "
    assert_not @post.valid?
  end

  test "logitude should be valid" do
    @post.longitude = " "
    assert_not @post.valid?
  end

  test "description should be valid" do
    @post.description = " "
    assert_not @post.valid?
  end

  test "description should not be too long" do
    @post.description = "a" * 256
    assert_not @post.valid?
  end
end
