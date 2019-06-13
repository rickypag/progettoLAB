require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  
  test "should get new" do
    get  new_user_path
    assert_response :success
  end
  
end
