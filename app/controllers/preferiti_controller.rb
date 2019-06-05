class PreferitiController < ApplicationController
   before_action :find_document

	def create
		@student_id = Student.find_by(email: current_user.email)
		if already_favourite?
			flash[:notice] = "Already it is your favourite"
		else
			@document.preferiti.create(student: Student.find_by(email: current_user.email))
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

