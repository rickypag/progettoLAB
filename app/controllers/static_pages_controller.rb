class StaticPagesController < ApplicationController
	before_action :logged_in?
	
	def home
	end

	def help
	end
  
	def about
	end
	
	private
	
	def logged_in?
		if user_signed_in?
			redirect_to current_student
		end
	end
end
