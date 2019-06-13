class ConsigliosController < ApplicationController
	layout 'principale'
	before_action :moderatore?, ecxept: [:new]
	
	def new
		@consiglio = Consiglio.new
	end
	
	def index
		@consiglios = Consiglio.all
	end
	
	def destroy
		@consiglio = Consiglio.find(params[:id])
		if @consiglio.destroy
			flash[:success] = "Il consiglio è stato cancellato"
		else
			flash[:error] = "Non è stato possibile cancellare il consiglio"
		end
		redirect_to consiglios_path
	end
	
	def create
		@consiglio = Consiglio.new(consiglio_params.merge(:user => current_user))
		if @consiglio.save
			flash[:success] = "Consiglio inviato ai moderatori"
		else
			flash[:error] = "Non è stato possibile inviare il consiglio ai moderatori"
		end
		redirect_to new_consiglio_path
	end
	
	private
	def consiglio_params
		params.require(:consiglio).permit(:testo)
	end
	
end
