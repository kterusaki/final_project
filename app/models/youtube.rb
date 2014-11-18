class Youtube
	attr_accessor :client
	def initialize
		@client = YouTubeIt::Client.new(:dev_key => "AIzaSyA4c2C8EwiERo_PP4uGm2B1sLdgqfLdcTI")
	end

	def valid_song(url)
		begin  
			video = @client.video_by(url)
			return true
		rescue OpenURI::HTTPError
			puts 'Invalid youtube url'
			#flash[:notice] = "Invalid youtube url"
			return false
		end 
	end

	def get_embedded(url)
		begin
			video = @client.video_by(url)
			return video.embed_url
		rescue OpenURI::HTTPError
			puts 'Invalid youtube url'
			return url
		end
	end

	def unshorten_url(url)
		response = Typhoeus.get(url)

		# parse the response for the unshortened url
		url = response.headers[:location]

		return url
	end
end