class DocumentsController < ApplicationController
	include ::DocumentsApi
	layout 'principale'
	
	def index
		if(params.has_key?(:query)  && params[:query] != "")
			query = params[:query].downcase
			@documents = Document.where("lower(title) LIKE ?", "%#{query}%")
		else
			@documents = Document.none
		end
	end
	
	def show
		@document = Document.find params[:id]
		@student = Student.find_by(email: current_user.email)
		@current_user = current_user
	end
	
	def new
		@document = Document.new
		@student = Student.find_by(email: current_user.email)
	end
	
	def create
		uploaded_io = params[:document][:file]
		a = ::DocumentsApi.getWhatEver(uploaded_io,params[:document][:title])
		render a
		#File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
		#	file.write(uploaded_io.read)
		#end
	end

	private
	
	def post_doc(file,title)
		url = URI.parse('https://ogv7kvalpf.execute-api.eu-west-1.amazonaws.com/dev/document')
		req = Net::HTTP::Post::Multipart.new url.path,"file" => UploadIO.new(file, "application/pdf", title + ".jpg")
		req.set_debug_output($stdout)
		res = Net::HTTP.start(url.host, url.port) do |http|
			http.request(req)
		end
		#render 'ciao'
	end
	
end
