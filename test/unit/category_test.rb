require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not be empty" do
    c=Category.new
    assert !c.valid
  end

  test "should require name" do
    assert_equal "Facebook", categories(:one).name
  end


end