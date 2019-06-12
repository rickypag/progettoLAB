require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
   
   def setup
    @user = users(:valid_example)
    users(:valid_example).password="foobar"
	users(:valid_example).password_confirmation="foobar"
  end

   
   test "Login with invalid information" do
    get new_user_session_path											#Visit the login path.
    assert_template 'sessions/new'										#
    post user_session_path, params: { email: "", password: "" }			#Request with not valid params
    #assert is_logged_in?
    assert_template 'sessions/new'										#
    assert_not flash.empty?												#flash presence verification
    get root_path														#change page
    assert flash.empty?													#flash not presence verification
  end
  
  test "login with valid information followed by logout" do
    get new_user_session_path
    post user_session_path, params: { email: @user.email, password: "foobar" }
    #assert is_logged_in?
    assert_not flash.empty?	
    assert_template "devise/shared/_links" 
    assert_template "devise/sessions/new"
    assert_template "layouts/application"
    assert_select "a[href=?]", new_user_session_path, count: 0			#login link not presence verification
    assert_select "a[href=?]",  destroy_user_session_path					#logout link presence verification
    
    delete destroy_user_session_path
    #assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", new_user_session_path
    #assert_select "a[href=?]", destroy_user_session_path, count: 0
    #assert_select "a[href=?]", user_path(@user), count: 0

  end
  
end
