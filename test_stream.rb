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

@client = TweetStream::Client.new

@client.on_error do |message|
  puts message
end

@client.on_timeline_status do |tweet|
  # response = Typhoeus.get('http://google.com')
  # puts response.headers[:location]
  puts tweet.text
  short_url = tweet.text.split(' ').find { |x| x =~ /\Ahttp(s)*:\/\/t.co/ }.gsub('https', 'http')

  response = Typhoeus.get(short_url)
  puts response.headers[:location]
end

@client.userstream