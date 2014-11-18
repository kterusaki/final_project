class HomeController < ApplicationController
	def index
		# initialize youtubeClient

		@tweets = Tweet.where(played: false, created_at: (Time.now- 1.hour)..Time.now)
	end

	
end
