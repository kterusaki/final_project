class TweetsController < ApplicationController
	def index
		@identity = Identity.find(params[:identity_id])
		@tweets = @identity.tweets.all
	end
end
