class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if !session[:return_to].blank?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
	  #if Student.find_by(email: resource.email)
		respond_with resource, :location => "students/a" #after_sign_in_path_for(resource)
	  #else
	    #respond_with resource, :location => "students/new" #after_sign_in_path_for(resource)
	  #end
    end
  end
end
