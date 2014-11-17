#require 'models/tweet_bot.rb'

task :get_songs => :environment do
	@bot = TweetBot.new
	@bot.getTweets()

	puts @bot.news_feed

	@bot.popPlayQueue()

	puts @bot.play_queue
end

task :test => :environment do
	puts 'hello'
end