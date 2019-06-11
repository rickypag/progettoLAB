require 'open-uri'

class DocumentsController < ApplicationController
	include ::DocumentsApi
	layout 'principale'
	before_action :moderatore?, only: [:delete]
	before_action :exist?, only: [:show]
	
	def pdf
		#pdf_file = ::DocumentsApi.download_doc("b2055bf7-4d18-40b8-99cf-a0cbe8e2f512")
		#pdf_filename = File.join(Rails.root, "public/uploads/test.pdf")
		#send_file(pdf_file, :filename => "aaa.pdf", :disposition => 'inline', :type => "application/pdf")
		uuid = params[:document_id]
		data = open("https://ogv7kvalpf.execute-api.eu-west-1.amazonaws.com/dev/document/" + uuid) 
		send_data data.read, filename: "doc.pdf", type: "application/pdf", disposition: 'inline', stream: 'true', buffer_size: '4096'
	end
	
	def txt
		uploaded_io = params[:document][:file]
		title = params[:document][:title]
		uuid = ::DocumentsApi.upload_txt(uploaded_io,title)
		render plain: uuid
		#file = (JSON.parse resp)['Files'][0]['FileData']
		#render plain: resp
		#file = Base64.decode64(file)
		#uuid = ::DocumentsApi.getWhatEver(file,params[:document][:title])
		#if uuid
		#	flash[:success] = "Documento caricato"
		#	@document = Document.find(uuid)
		#	redirect_to @document
		#else
		#	flash[:error] = "errore"
		#	render 'documents/new'
		#end
		#send_data file, filename: "doc.pdf", type: "application/pdf", disposition: 'inline'
	end
	
	def index
		if(params.has_key?(:query)  && params[:query] != "")
			query = params[:query].downcase
			@documents = Document.where("lower(title) LIKE ? and not eliminato", "%#{query}%")
		else
			@documents = Document.none
		end
	end
	
	def show
		#render plain: params[:id]
		@document = Document.find params[:id]
		c = Cronologium.where(student_id: current_student, document_id: @document).first
		if !!c
			Cronologium.where(student_id: current_student, document_id: @document).delete_all
		end
		current_student.cronologium.create(document: @document)
		@student = current_student
		@current_user = current_user
	end
	
	def new
		@document = Document.new
		@student = Student.find_by(email: current_user.email)
	end
	
	def create
		uploaded_io = params[:document][:file]
		uuid = ::DocumentsApi.getWhatEver(uploaded_io.tempfile,params[:document][:title])
		if uuid
			flash[:success] = "Documento caricato"
			@document = Document.find(uuid)
			redirect_to @document
		else
			flash[:error] = "errore"
			render 'students/new'
		end
		#File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
		#	file.write(uploaded_io.read)
		#end
	end

	def delete
		@document = Document.find params[:document_id]
		@document.update(eliminato: true)
		redirect_to current_student
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
	
	def exist?
		@document = Document.find params[:id]
		raise ActionController::RoutingError.new('Not Found') unless (@document && @document.eliminato == false)
	end
	
	
end
