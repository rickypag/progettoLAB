class LikesController < ApplicationController
	before_action :find_document

	def like
		@student_id = Student.find_by(email: current_user.email)
		if already_liked?
			flash[:notice] = "You can't like more than once"
		else
			@document.likes.create(student: Student.find_by(email: current_user.email), :val => true)
		end
		redirect_to document_path(@document)
	end
	
	def dislike
		@student_id = Student.find_by(email: current_user.email)
		if already_disliked?
			flash[:notice] = "You can't dislike more than once"
		elsif
			@document.likes.create(student: Student.find_by(email: current_user.email), :val => false)
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
