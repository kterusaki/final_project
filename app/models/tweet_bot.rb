require 'time'

class TweetBot
	attr_accessor :client, :youtubeClient

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

		# Initialize client
		@client = TweetStream::Client.new

		@client.on_error do |message|
			puts message
		end

		@youtubeClient = Youtube.new
	end

	def start_stream
		@client.userstream
	end

	# Gets the tweets from the twitter accounts newsfeed
	def getTweets
		puts 'in getTweets'
		@client.on_timeline_status do |tweet|
			puts 'getTweets: ' + tweet.text

			#binding.pry
			popPlayQueue(tweet)
		end
	end

	# Validates that the tweet's text is a requested song
	def valid_tweet(tweet)
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
		if valid_tweet(tweet)
			shortUrl = grab_url(tweet)
			
			puts shortUrl
			youtubeUrl = @youtubeClient.unshorten_url(shortUrl)
			
			if @youtubeClient.valid_song(youtubeUrl)
				embed_url = @youtubeClient.get_embedded(youtubeUrl)
				video = @youtubeClient.get_video(youtubeUrl)

				if check_user(tweet.user.id)
					insertTweet(tweet.user.id, tweet.text, embed_url, video.unique_id, video.title, tweet.user.name)
				end
			end
		end
	end

	# Returns the url in the tweet text, if it exists
	def grab_url(tweet)
		# only grabs the url from the tweet text and replaces any https with http
		tweet.text.split(' ').find { |hunk| hunk =~ /\Ahttps{0,1}:\/\/t.co/ }.gsub('https', 'http')
	end

	# Adds Tweet to database
	def insertTweet(userId, text, youtubeUrl, video_id, vid_title, twitter_handle)
		# Since we're finding based on a foreign key, we can assume the search will only return one identity
		twitter_user = Identity.where(uid: userId).take!
		newTweet = Tweet.new
		newTweet.text = text
		newTweet.youtube_url = youtubeUrl
		newTweet.video_id = video_id
		newTweet.twitter_id = userId
		newTweet.played = false
		newTweet.identity_id = twitter_user.id
		newTweet.from_user = twitter_handle
		newTweet.vid_title = vid_title

		newTweet.save
	end

	def check_user(twitter_id)
		if Identity.where(uid: twitter_id)
			return true
		else
			return false
		end
	end

	def self.test_stream
		@bot = TweetBot.new
		@bot.getTweets
		@bot.start_stream
	end

	private
		def tweet_params
			params.require(:tweet).permit(:text)
		end

end



