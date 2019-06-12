require 'test_helper'

class StudentsSignupTest < ActionDispatch::IntegrationTest
	 
	 test "invalid students signup information" do
		
		post users_path, params: { user: { name:  "Bellone",
                               email: "user@valid.com",
                               password:              "foobar",
                               password_confirmation: "foobar" }}
		
		assert_no_difference 'Student.count', 1 do
			post students_path, params:  {email: "user@valid.com" ,
										student: {username: "", name: "", 
										surname: "", university: "", 
										faculty: "" }}
		end
		assert_template 'students/new'
	end
	
	
	test "valid students signup information" do
		
		post users_path, params: { user: { name:  "Bellone",
                               email: "user@valid.com",
                               password:              "foobar",
                               password_confirmation: "foobar" }}
		
		assert_difference 'Student.count', 1 do
			post students_path, params:  {email: "user@valid.com" ,
										student: {username: "userval", name: "valido", 
										surname: "user", university: "Sapienza", 
										faculty: "IgBestmmie" }}
		end
		
	end

end
