response = Faraday.get("https://accounts.google.com/o/oauth2/auth?client_id=750028081068-pg82pmf5vej15asc7ci3d64i8hgsq10g.apps.googleusercontent.com&redirect_uri=http://localhost:3000&scope=https://gdata.youtube.com&response_type=code&approval_prompt=auto&access_type=offline")


puts decode_uri = URI.unescape(response.body)

conn = Faraday.new(:url => 'https://accounts.google.com',:ssl => {:verify => false}) do |faraday|
   faraday.request  :url_encoded
   faraday.response :logger
   faraday.adapter  Faraday.default_adapter
  end

 result = conn.post '/o/oauth2/token', {'code' => "4/ogd3t2K9RtsekWtVhIH11rG9XwfRU_mPdn4bhVbqGiA.coa1P8IyvZUeEnp6UAPFm0HM3viSkwI",
 'client_id' => "750028081068-pg82pmf5vej15asc7ci3d64i8hgsq10g.apps.googleusercontent.com",
 'client_secret' => "hk858jpKUhtQJfrmtrA_oQpI",
 'redirect_uri' => "http://localhost:3000",
 'grant_type' => 'authorization_code'}

 binding.pry
 puts result.body.inspect