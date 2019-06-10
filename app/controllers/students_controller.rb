class StudentsController < ApplicationController
	layout :resolve_layout
	before_action :correct_user,   only: [:edit, :update]
	before_action :current_student
	before_action :moderatore?, only: [:fai_mod]
	
	def fai_mod
		@student = 
	end
	
	def preferiti
		@preferiti = @student.preferiti
	end
	
	def new
		@student = Student.new
	end

	def index
		if(params.has_key?(:query) && params[:query] != "")
			query = params[:query].downcase
			@students = Student.where("lower(username) LIKE ?", "%#{query}%")
		else
			@students = Student.none
		end
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
    
    def current_student
      @student = Student.find_by(email: current_user.email)
    end 
	
end
