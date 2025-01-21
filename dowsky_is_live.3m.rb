#!/usr/bin/env /Users/nathanielpierson/.rbenv/shims/ruby
require 'http'
request = HTTP.headers(:client_id => "pnyd2wx6lmfrsubv7jd2rmakek0g7h").auth("Bearer v3y6hy744layrep52r2hlhdj7nmgv7").get("https://api.twitch.tv/helix/search/channels?query=dowsky&live_only=false")
get_info = request.parse
dowsky_live = false
real_dowsky = false
x = 0
while real_dowsky == false
  temp = get_info["data"][x]["display_name"]
  if temp == "Dowsky"
    real_dowsky = true
    if get_info["data"][x]["is_live"] == true
      dowsky_live = true
      game = get_info["data"][x]["game_name"]
    else
      dowsky_live = false
    end
  else
    x += 1
  end
end
if dowsky_live == true
  puts "Dowsky is live"
  puts "---"
  puts "currently playing: #{game}."
else
  puts "Dowsky is not live."
end