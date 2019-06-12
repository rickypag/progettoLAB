require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
   
   def setup
    @user = users(:valid_example)
    users(:valid_example).password="foobar"
	users(:valid_example).password_confirmation="foobar"
  end

  test "unsuccessful edit" do
    get edit_user_password_path(@user)
    #assert_template 'users/edit'										#rendering with <[]>
    patch user_password_path, params: {password:              "foo",
                                    password_confirmation: "bar" }
    assert_template "devise/shared/_error_messages" 
    assert_template "devise/shared/_links"
    assert_template "devise/passwords/edit" 
    assert_template "layouts/application"
  end
  
  test "successful edit" do
    get edit_user_password_path(@user)
    #assert_template 'users/edit'
    email = @user.email
    patch user_password_path, params: {password: "ciaociao",
                                    password_confirmation: "ciaociao" }
    assert_not flash.empty?
    assert_template "devise/shared/_links"
    assert_template "devise/passwords/edit" 
    assert_template "layouts/application" 
    @user.reload
    assert_equal @user.email, email
  end

end
