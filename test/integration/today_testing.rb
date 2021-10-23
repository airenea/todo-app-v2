require "test_helper"

class TodayTesting < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
    test "Should view task" do
        sign_in users(:one)
        get new_category_path
        assert_response :success
        post categories_path, params: {
          category: {
            title: "category",
            body: "unique_key1234567890",
            emoji: "😜",
          } 
        }
        @cat_id = Category.where(body: 'unique_key1234567890')[0].id
        get new_task_path
        assert_response :success
        post tasks_path, params: {
          task: {
            title: "tomorrow",
            body: "unique_key12345678901",
            completion: false,
            category_id: @cat_id,
            date: Date.current+1,
          } 
        }
        follow_redirect!
        get "/tasks"
        assert_select "h2", false, "This page must contain no tasks"
      end
end