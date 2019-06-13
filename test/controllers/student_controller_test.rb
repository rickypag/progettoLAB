require 'test_helper'

class StudentControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
  
  #crezione user per nuovo student
	post users_path, params: { user: { name:  "Bellone",
                               email: "user@valid.com",
                               password:              "foobar",
                               password_confirmation: "foobar" }}
  
    get  new_student_path 
    assert_response :success
  end
end
