class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
	if resource.is_a?(User) && Student.find_by(email: resource.email)
		username = Student.find_by(email: resource.email).username
		"/students/#{username}"
	else
		"/students/new"
	end
  end
  
  private
  
  def return_path(resource)
	if true #resource.is_a?(User) && Student.find_by(email: resource.email)
		"students/new"
	else
		'/students/a'
	end
  end
  
end
