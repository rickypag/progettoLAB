class StudentsController < ApplicationController
	layout :resolve_layout
	
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
