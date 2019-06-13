class RulesController < ApplicationController
	layout 'principale'
	before_action :moderatore?, ecxept: [:index]
	
	def index
		@rules = Rule.all
	end
	
	def new
		@rule = Rule.new
	end
	
	def destroy
		@rule = Rule.find(params[:id])
		if @rule.destroy
			flash[:success] = "La regola è stata cancellata"
		else
			flash[:error] = "Non è stato possibile cancellare la regola"
		end
		redirect_to rules_path
	end
	
	def create
		@rule = Rule.new(rule_params)
		if @rule.save
			flash[:success] = "Nuova regola aggiunta con successo"
		else
			flash[:error] = "Non è stato possibile inserire una nuova regola"
		end
		redirect_to rules_path
	end
	
	private
	def rule_params
		params.require(:rule).permit(:testo)
	end
end
