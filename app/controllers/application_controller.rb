class ApplicationController < ActionController::Base
  helper_method :moderatore?
  helper_method :current_student
  
  def moderatore?
    current_user && current_user.role == "moderatore"
  end

  def after_sign_in_path_for(resource)
	if resource.is_a?(User) && Student.find_by(email: resource.email)
		"/students/a"
	else
		"/students/new"
	end
  end
  
  def current_student
	@student = Student.find_by(email: current_user.email)
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
