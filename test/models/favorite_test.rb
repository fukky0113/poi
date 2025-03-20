require "test_helper"

class FavoriteTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
    @post = posts(:post)
    @favo = Favorite.new(user_id: @user.id, post_id: @post.id)
  end

  test "should be valid" do
    assert @favo.valid?
  end

  test "user_id should be valid" do
    @favo.user_id = " "
    assert_not @favo.valid?
  end

  test "post_id should be valid" do
    @favo.post_id = " "
    assert_not @favo.valid?
  end
end
