class StudentsController < ApplicationController
	layout :resolve_layout
<<<<<<< HEAD
	before_action :correct_user,   only: [:edit, :update]
	before_action :current_student
	before_action :moderatore?, only: [:fai_mod]
	
	def fai_mod
		@student = 
	end
	
	def preferiti
		@preferiti = @student.preferiti
	end
=======
>>>>>>> c63412f323eb3b6124db28c340a232abef7923b1
	
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
	end
	
	private
	
	def student_params
		params.require(:student).permit(:username, :name, :surname, :university, :faculty)
	end
	
	
  private

  def resolve_layout
    case action_name
    when "new", "create"
      "application"
    else
      "principale"
    end
  end
  
	
end
