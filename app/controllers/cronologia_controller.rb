class CronologiaController < ApplicationController
	before_action :find_document
	
	def show
		#@cronologium = @student.cronologium.order(created_at: :desc)
	end
	
	def create
		c = Cronologium.where(student_id: current_student, document_id: @document).first
		if !!c
			Cronologium.where(student_id: current_student, document_id: @document).delete_all
		end
		current_student.cronologium.create(document: @document)
	end
	
	private
	
	def find_document
		@document = Document.find(params[:document_id])
	end
	
end
