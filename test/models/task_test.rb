require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "No name" do
    task = Task.create(title: nil)
    assert_not task.save, "Saved a task without a name"
  end

  test "No category" do
    task = Task.create(category: nil)
    assert_not task.save, "Saved a task without a category"
  end

  test "No date" do
    task = Task.create(date: nil)
    assert_not task.save, "Saved a task without a date"
  end

end
