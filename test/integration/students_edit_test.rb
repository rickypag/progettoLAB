require 'test_helper'

class StudentsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    #create user and student
	post users_path, params: { user: { name:  "Bellone",
                               email: "user@valid.com",
                               password:              "foobar",
                               password_confirmation: "foobar" }}
		
	
	post students_path, params:  {email: "user@valid.com" ,
								student: {username: "userval", name: "valido", 
								surname: "user", university: "Sapienza", 
								faculty: "IgBestmmie" }}
	@student = Student.find_by(email: "user@valid.com")
  end
  
  
  
  test "unsuccessful student edit" do
	
	
	get edit_student_path(@student)
    assert_template "students/edit"
    patch update_student_path(@student),params:  {id: @student.id, student: 
								{ username: "", name: "", surname: "", 
											university: "", faculty: "", 
											email: "example!xmdfp.com"}}
    assert_template "shared/_error_messages" 
    assert_template "students/edit"
   
  end
  
  test "successful student edit" do
	
	
	get edit_student_path(@student)
    assert_template "students/edit"
    patch update_student_path(@student),params:  {id: @student.id, student: 
								{ name: "Paolino", surname: "Paperino", 
											university: "Sapienza", faculty: "Iginf", 
											bio: "studente"}}
    assert_redirected_to @student
  end
  
end
