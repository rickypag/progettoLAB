class StudentsController < ApplicationController
	layout :resolve_layout
	before_action :correct_user,   only: [:edit, :update]
	before_action :current_student
	before_action :moderatore?, only: [:fai_mod, :delete_mod]
	before_action :find_student
	
	def fai_mod
		User.where(email: @this_student.email).first.update(role: "moderatore")
		flash[:success] = "Questo utente ora è un moderatore"
		redirect_to @this_student
	end
	
	def delete_mod
		User.where(email: @this_student.email).first.update(role: "student")
		flash[:success] = "Questo utente non è più un moderatore"
		redirect_to @this_student
	end
	
	def preferiti
		@preferiti = @student.preferiti
	end
	
	def cronologia
		@cronologium = @student.cronologium.order(created_at: :desc)
	end
	
	def cancella_cronologia
		Cronologium.where(student_id: current_student).delete_all
		flash[:success] = "La cronologia è stata cancellata con successo"
		redirect_to student_cronologia_path
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
    
    def find_student
		@this_student = Student.where(username: params[:student_id]).first
	end
	
end
