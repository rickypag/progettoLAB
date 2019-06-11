require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid users signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }}
    end
    assert_template "devise/shared/_error_messages"
    assert_template "devise/shared/_links"
    assert_template "devise/registrations/new"
    assert_template "layouts/application"
  end
  
  test "valid users signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Bellone",
                               email: "user@valid.com",
                               password:              "foobar",
                               password_confirmation: "foobar" }}
    end
    #assert_template "shared/_error_messages"
    #assert_template "students/new"
    #assert_template "layouts/application"
  end
  
end
