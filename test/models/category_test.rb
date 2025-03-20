require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = categories(:category)
  end

  test "should be valid" do
    assert @category.valid?
  end
  
  test "g_type should be valid" do
    @category.g_type = " "
    assert_not @category.valid?
  end

  test "category addresses should be unique" do
    duplication_category = @category.dup
    @category.save
    assert_not duplication_category.valid?
  end
end
