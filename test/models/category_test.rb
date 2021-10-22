require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "No name" do
    task = Category.create(title: nil)
    assert_not task.save, "Saved a task without a name"
  end

  test "No emoji" do
    task = Category.create(emoji: nil)
    assert_not task.save, "Saved a task without an emoji"
  end

  test "No user" do
    task = Category.create(user: nil)
    assert_not task.save, "Saved a task without a user"
  end
end
