require 'time'

class TweetBot
	attr_accessor :client, :play_queue, :news_feed

	def initialize
		TweetStream.configure do |config|
			# config.consumer_key = ENV["CONSUMER_KEY"]
			# config.consumer_secret = ENV["CONSUMER_SECRET"]
			# config.oauth_token = ENV["OAUTH_TOKEN"]
			# config.oauth_token_secret = ENV["OAUTH_TOKEN_SECRET"]

			config.consumer_key = "NpKvakF9JBjciNqPQTinN5CXX"
			config.consumer_secret = "eUJaWfRjDNg8T0HDMGQ7hykYI9tllKuTPVIJTaXlVqvsGr0vNx"
			config.oauth_token = "2899021542-iXxQCF1OsEe3el2CEB6BDzdBRjbPsDkgRBLjpdG"
			config.oauth_token_secret = "sBNIRzxn5fdOdjQIUj2lUJkXPcnaZGxDqU4GgjZj0ztxa"
			config.auth_method = :oauth
		end

		# Initialize client and play queue
		@client = TweetStream::Client.new
		@play_queue = []
		@news_feed = []
	end

	def start_stream
		@client.userstream
	end

	# Gets the tweets from the twitter accounts newsfeed
	def getTweets
		puts 'in getTweets'
		@client.on_timeline_status do |tweet|
			puts 'getTweets: ' + tweet.text
			@news_feed.push(tweet)

			popPlayQueue(tweet)
		end
	end

	# Validates that the tweet's text is a youtube url
	def isYoutubeURL(tweet)
		@url = tweet.text

		if @url.include? "#radio"
			return true
		else
			return false
		end
	end

	# Populates the play queue with requested songs
	def popPlayQueue(tweet)
		#binding.pry
		# Add url to play queue if the tweet is a youtube/watch url
		if isYoutubeURL(tweet)
			@play_queue.push(tweet)
		end

		#puts @play_queue
	end

	# Adds Tweet to database
	def insertTweet(tweet)
		@tweet = Tweet.create(tweet_params)
	end

	# Empties the play queue
	def emptyPlayQueue()
		@play_queue = []
	end

	# TODO: Create a method that creates an instance of the Tweet model and stores all of the information in the database

	def self.test_stream
		@bot = TweetBot.new
		@bot.getTweets
		@bot.start_stream
	end

	def private
		def tweet_params
			params.require(:tweet).permit(:text)
		end
end



