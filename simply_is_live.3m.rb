#!/usr/bin/env /Users/nathanielpierson/.rbenv/shims/ruby
require 'http'
streamer = "Simply"
request = HTTP.headers(:client_id => "pnyd2wx6lmfrsubv7jd2rmakek0g7h").auth("Bearer v3y6hy744layrep52r2hlhdj7nmgv7").get("https://api.twitch.tv/helix/search/channels?query=#{streamer}&live_only=false")
get_info = request.parse
streamer_live = false
real_streamer = false
x = 0
while real_streamer == false
  temp = get_info["data"][x]
  if temp["display_name"] == "#{streamer}"
    real_streamer = true
    if temp["is_live"] == true
      streamer_live = true
      game = temp["game_name"]
    else
      streamer_live = false
    end
  else
    x += 1
  end
end
if streamer_live == true
  puts "#{streamer} is live"
  puts "---"
  puts "currently playing #{game}"
else
  puts "#{streamer} is not live."
end