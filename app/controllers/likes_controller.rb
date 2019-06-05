class LikesController < ApplicationController
	before_action :find_document

	def create
		val = params[:value]
		@student_id = Student.find_by(email: current_user.email)
		if val && already_liked?
			flash[:notice] = "You can't like more than once"
		elsif !val && already_disliked?
			flash[:notice] = "You can't dislike more than once"
		elsif !val && already_liked?
			Like.where(student_id: @student, document_id: params[:document_id]).update(:val => val)
		elsif @val && already_disliked?
			Like.where(student_id: @student, document_id: params[:document_id]).update(:val => val)
		else
			@document.likes.create(student: Student.find_by(email: current_user.email), :val => val)
		end
		redirect_to document_path(@document)
	end
	
	def destroy
		if !(already_liked?)
			flash[:notice] = "Cannot unlike"
		else
			@like.destroy
		end
		redirect_to document_path(@document)
	 end

	private
	
	def already_liked?
		Like.where(student_id: Student.find_by(email: current_user.email), document_id: params[:document_id], val: true).exists?
	end
	
	def already_disliked?
		Like.where(student_id: Student.find_by(email: current_user.email), document_id: params[:document_id], val: false).exists?
	end

	def find_document
		@document = Document.find(params[:document_id])
	end

end
