class HomeController < ApplicationController
	def index
		@tweets = Tweet.where(played: false, created_at: (Time.now- 1.hour)..Time.now)

		@tweets_list = @tweets.to_ary
		#binding.pry
		@videos = []
		@tweets_list.each do |tweet|
			@videos.push(tweet.video_id) 
		end
	end

	
end
