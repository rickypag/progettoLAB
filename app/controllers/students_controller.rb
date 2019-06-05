class StudentsController < ApplicationController
	layout :resolve_layout
	before_action :correct_user,   only: [:edit, :update]
	
	def new
		@student = Student.new
	end

	def index
	end
	
	def create
		@student = Student.new(student_params.merge(:email => current_user.email))
		if @student.save
			redirect_to @student
		else
			render 'students/new'
		end
	end
	
	def show
		@student = Student.find params[:id]
		@current_user = current_user
	end
	
	def edit
		#@student = Student.find_by(email: current_user.email)
	end
	
	def update
		if @student.update_attributes(update_params)
			flash[:success] = "Profile updated"
			redirect_to @student
		else
			render 'edit'
		end
	end
	
	private
	
	def student_params
		params.require(:student).permit(:username, :name, :surname, :university, :faculty)
	end
	
	def update_params
		params.require(:student).permit(:name, :surname, :university, :faculty, :bio)
	end
	

  def resolve_layout
    case action_name
    when "new", "create"
      "application"
    else
      "principale"
    end
  end
  
    def correct_user
      @student = Student.find(params[:id])
      @user = User.find_by(email: @student.email)
      redirect_to(root_url) unless @user == current_user
    end 
	
end
