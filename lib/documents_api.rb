require 'net/http/post/multipart'

module DocumentsApi
     class << self
     	def headers
     		return {
     			'Content-Type' => 'application/json, charset=utf8'
     		}
     	end
     
    	// you can add more logic here
    	def getWhatEver(file,title)
			url = URI.parse('https://ogv7kvalpf.execute-api.eu-west-1.amazonaws.com/dev/document')
			req = Net::HTTP::Post::Multipart.new url.path,"file" => UploadIO.new(file, "application/pdf", title + ".jpg")
			#req.set_debug_output($stdout)
			res = Net::HTTP.start(url.host, url.port) do |http|
				http.request(req)
			end
			res
     	end
     	
     	def download_doc(uuid)
			uri = URI.parse("https://ogv7kvalpf.execute-api.eu-west-1.amazonaws.com/dev/document/{#uuid}")

			http         = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			
			request = Net::HTTP::Get.new(uri.path)

			http.request(request)
     	end
end
