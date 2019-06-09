class ReportController < ApplicationController
	before_action :find_document

	def create
		@student = current_student
		if already_reported?
			flash[:notice] = "Already reported"
		else
			@document.report.create(student: current_student)
			flash[:notice] = "Il documento è stato segnalato ai moderatori"
		end
		redirect_to document_path(@document)
	end
	
	
	private
	
	def already_reported?
		Report.where(student_id: current_student, document_id: params[:document_id]).exists?
	end
	
	def find_document
		@document = Document.find(params[:document_id])
	end
	
end
