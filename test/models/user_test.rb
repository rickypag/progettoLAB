require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
	users(:valid_example).password="foobar"
	users(:valid_example).password_confirmation="foobar"
	users(:invalid_example).password="bel"
	users(:invalid_example).password_confirmation="bel"
	@user = users(:invalid_example)
  end
  
  test "should be valid" do
	assert users(:valid_example).valid?
	assert_not users(:invalid_example).valid?
  end
  
  test "email should be present" do
	@user.email= ""
	assert_not @user.valid?
  end
  
  test "email should be unique" do
    dup_user = @user.dup
    #@user.save
    assert_not dup_user.valid?
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email shoul not be too long" do
	@user.email="a"*244 +"@example.com" #should be <= 255
	assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
	@user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
	
end
