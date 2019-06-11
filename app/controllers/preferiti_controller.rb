class PreferitiController < ApplicationController
	before_action :find_document
	layout 'principale'
	
	def show
		@preferiti = @student.preferiti
	end

	def create
		@student_id = Student.find_by(email: current_user.email)
		if already_favourite?
			Preferiti.where(student: Student.find_by(email: current_user.email)).delete_all
			flash[:notice] = "Non è più un tuo preferito"
		else
			@document.preferiti.create(student: Student.find_by(email: current_user.email))
			flash[:notice] = "Hai aggiunto questo documento ai tuoi preferiti"
		end
		redirect_to document_path(@document)
	end

	private

	def already_favourite?
		Preferiti.where(student_id: Student.find_by(email: current_user.email), document_id: params[:document_id]).exists?
	end
	
	def find_document
		@document = Document.find(params[:document_id])
	end
  
end

