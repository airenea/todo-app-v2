require "test_helper"

class TaskTesting < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "Should create a task" do
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
        title: "task",
        body: "unique_key12345678901",
        completion: false,
        category_id: @cat_id,
        date: Date.current,
      } 
    }
    assert_equal( 1, Task.where(body: "unique_key12345678901").count, "New task!" )
  end

  test "Should create a task in a certain category" do
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
        title: "task",
        body: "unique_key12345678901",
        completion: false,
        category_id: @cat_id,
        date: Date.current,
      } 
    }
    @task = Task.where(body: "unique_key12345678901")[0]
    assert_equal( @task.category_id, @cat_id, "In the category!")
  end

  test "Should edit task" do
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
        title: "task",
        body: "unique_key12345678901",
        completion: false,
        category_id: @cat_id,
        date: Date.current,
      } 
    }
    @task = Task.where(body: "unique_key12345678901")[0]    

    assert_equal( "task", @task.title, "Same name!" )
    @task.update(:title => "edited")
    assert_equal( "edited", @task.title, "Edited name!" )
  end

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
        title: "task",
        body: "unique_key12345678901",
        completion: false,
        category_id: @cat_id,
        date: Date.current,
      } 
    }
    @task = Task.where(body: "unique_key12345678901")[0]    
    @task_link = '/tasks/' + @task.id.to_s
    assert_redirected_to @task_link
    follow_redirect!
    assert_select 'span.taskindiv-titletest', "task"
  end

  test "Should delete task" do
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
        title: "task",
        body: "unique_key12345678901",
        completion: false,
        category_id: @cat_id,
        date: Date.current,
      } 
    }
    @task = Task.where(body: "unique_key12345678901")[0]  
    assert_difference("Task.count", -1) do
      delete task_path(@task.id)
    end
  end

end
