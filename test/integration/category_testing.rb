require "test_helper"

class CategoryTesting < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "Should create a category" do
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
    assert_equal( 1, Category.where(body: "unique_key1234567890").count, "New category!" )
  end

  test "Should edit category" do
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
    assert_equal( "category", Category.where(id: @cat_id)[0].title, "Same name!" )
    Category.where(id: @cat_id)[0].update(:title => "edited")
    assert_equal( "edited", Category.where(id: @cat_id)[0].title, "Edited name!" )
  end

  test "Should view category" do
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
    @cat_link = '/categories/' + @cat_id.to_s
    assert_redirected_to @cat_link
    follow_redirect!
    assert_select 'span.catindiv-titletest', "category"
  end
end
