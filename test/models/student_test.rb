require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  
  def setup
	@student = Student.new(name: "Example", surname: "Example", username: "example")
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
  
  test "username should be unique" do
    dup_stud = @student.dup
    @student.save
    assert_not dup_stud.valid?
  end
  #to do: aggiungere uniqe a livello db ----> Fatto: db/migrate/20190607082417_add_index_to_students_username.rb
  
end
