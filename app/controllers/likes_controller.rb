class LikesController < ApplicationController
	before_action :find_document

	def like
		@student = Student.find_by(email: current_user.email)
		if already_liked?
			#Tolgo il like
			#flash[:notice] = "You can't like more than once"
			Like.where(document: @document,student: @student).delete_all
		elsif already_disliked?
			Like.where(document: @document,student: @student).update_all(:val => true)
		else
			@document.likes.create(student: @student, :val => true)
		end
		redirect_to document_path(@document)
	end
	
	def dislike
		@student = Student.find_by(email: current_user.email)
		if already_disliked?
			#Tolgo il dislike
			#flash[:notice] = "You can't dislike more than once"
			Like.where(document: @document,student: @student).delete_all
		elsif already_liked?
			Like.where(document: @document,student: @student).update_all(:val => false)
		else
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
