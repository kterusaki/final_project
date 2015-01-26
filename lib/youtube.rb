class Youtube
	attr_accessor :client
	def initialize
		#response = Typhoeus.get("https://accounts.google.com/o/oauth2/auth?client_id=750028081068-pg82pmf5vej15asc7ci3d64i8hgsq10g.apps.googleusercontent.com&redirect_uri=http://localhost:3000&scope=https://gdata.youtube.com&response_type=code&approval_prompt=auto&access_type=offline")
		#?code=4/HRtan8WS5KHUdn9gd5hjnPMNqZxHUbJUEF88nfsXNTY.wvQ3oOS70isb3oEBd8DOtNDFm7gclAI
		@client = YouTubeIt::Client.new(:dev_key => "AI39si6LXuhlmQ0_F_ugn2FPxqtuvWb5Ad5wPTnpJQG1DDN_nPCcfTMCzIDUhIBZtDUY0qJC4-YRLnbU4NvmpDwprQNKAiX3Hg")
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

	def get_video(url)
		begin  
			video = @client.video_by(url)
			return video
		rescue OpenURI::HTTPError
			puts 'Invalid youtube url'
			#flash[:notice] = "Invalid youtube url"
			return
		end 
	end
end