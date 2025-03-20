require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
    @post = posts(:post)
    @comment = Comment.new(user_id: @user.id, post_id: @post.id, comment: "コメント")
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "user_id should be valid" do
    @comment.user_id = " "
    assert_not @comment.valid?
  end

  test "post_id should be valid" do
    @comment.post_id = " "
    assert_not @comment.valid?
  end

  test "comment should be valid" do
    @comment.comment = " "
    assert_not @comment.valid?
  end
  
  test "comment should not be too long" do
    @comment.comment = "z" * 256
    assert_not @user.valid?
  end
end
