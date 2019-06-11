require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  
  def setup
	@student = Student.create(name: "Example", surname: "Example", username: "example", email: "example@xmdfp.com")
  end
  
  test "should be valid" do
	assert @student.valid?
  end
  
  test "name should be present" do
	@student.name= ""
	assert_not @student.valid?
  end
  
  test "surname should be present" do
	@student.surname= ""
	assert_not @student.valid?
  end
  
  test "username should be present" do
	@student.username= ""
	assert_not @student.valid?
  end
  
  #test "username should be unique" do
  #  dup_stud = @student.dup
  #  @student.save
  #  assert_not dup_stud.valid?
  #end
  #to do: aggiungere uniqe a livello db ----> Fatto: db/migrate/20190607082417_add_index_to_students_username.rb
  
  test "name should not be too long" do
	@student.name="a"*11
	assert_not @student.valid?
  end 
  
  test "surname should not be too long" do
	@student.name="a"*11
	assert_not @student.valid?
  end 
  
  test "username should not be too long" do
	@student.name="a"*11
	assert_not @student.valid?
  end 
  
  test "username validation should reject invalid username" do
    invalid_username = ["Cia o", "Ci.ao", "Ci*ao", "cia,o", "123ciao"]
    invalid_username.each do |invalid_username|
      @student.username = invalid_username
      assert_not @student.valid?, "#{invalid_username.inspect} should be invalid"
    end
  end
  
  test "email should be present" do
	@student.email= ""
	assert_not @student.valid?
  end
  
  test "email should be unique" do
    dup_stud = @student.dup
    @student.save
    assert_not dup_stud.valid?
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @student.email = invalid_address
      assert_not @student.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email shoul not be too long" do
	@student.email="a"*244 +"@example.com" #should be <= 255
	assert_not @student.valid?
  end
  
end
