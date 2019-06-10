require 'net/http/post/multipart'
#require 'rest_client'
require 'convert_api'
require 'tmpdir'

ConvertApi.configure do |config|
  config.api_secret = 'w3tZfwLKj8dI8MdL'
end


module DocumentsApi
     class << self
     	def headers
     		return {
     			'Content-Type' => 'application/json, charset=utf8'
     		}
     	end

		def model_params(file,title)
			require_params = { :title => title }
			require_params[:file] = UploadIO.new(file, "application/pdf", title + ".pdf")
			#require_params[:title] = title
			require_params
		end
		
		def params_txt(file,title)
			require_params = { :file => UploadIO.new(file.tempfile, "text/plain", title + ".txt") }
			#require_params[:title] = title
			require_params
		end
		
		def getUserData(a,b)
			uri = URI('https://nxpsk4j5ma.execute-api.eu-west-1.amazonaws.com/alpha/userData?username=paperino')
			return Net::HTTP.get(uri) # => String
		end

    	def getWhatEver(file,title)
			url = URI.parse('http://univercity.eu-west-1.elasticbeanstalk.com/document')
			Net::HTTP.start(url.host, url.port) do |http|
				req = Net::HTTP::Post::Multipart.new(url, model_params(file,title))
				return http.request(req).body
			end
     	end
     	
     	def params(file)
			params = { "title" => "A nice picture!" }
			params[:file] = UploadIO.new(file, "application/pdf", "image.pdf")
			params
		end
		
		def upload_txt(file,title)
			#url = URI.parse('http://v2.convertapi.com/convert/txt/to/pdf?Secret=w3tZfwLKj8dI8MdL')
			upload_io = ConvertApi::UploadIO.new(file.tempfile)
			
			dir = Dir.tmpdir + "/" + title + ".pdf"
			
			saved_files = ConvertApi
				.convert('pdf', File: upload_io)
					.save_files(dir)
			
			url = URI.parse('http://univercity.eu-west-1.elasticbeanstalk.com/document')
			Net::HTTP.start(url.host, url.port) do |http|
				req = Net::HTTP::Post::Multipart.new(url, model_params(File.open(dir),title))
				return http.request(req).body
			end

			#Net::HTTP.start(url.host, url.port) do |http|
			#	req = Net::HTTP::Post::Multipart.new(url, params_txt(file,title))
			#	return http.request(req).body
			#end
		end
		
		def download_doc(uuid)
			uri = URI.parse("https://ogv7kvalpf.execute-api.eu-west-1.amazonaws.com/dev/document/" + uuid)

			http         = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			
			request = Net::HTTP::Get.new(uri.path)

			http.request(request).body
     	end
     	
     	

     	def tmp(a,b)
			url = URI.parse('https://ogv7kvalpf.execute-api.eu-west-1.amazonaws.com/dev/document')
			File.open("public/uploads/test.pdf") do |file|
				req = Net::HTTP::Post::Multipart.new(url.path, params(file))
				#req.use_ssl = (url.scheme == "https")
				res = Net::HTTP.start(url.host, url.port) do |http|
					return http.request(req).body
				end
			end
     	end
     	
     end
end
