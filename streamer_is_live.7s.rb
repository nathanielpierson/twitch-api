#!/usr/bin/env /Users/nathanielpierson/.rbenv/shims/ruby
require 'http'
# array of streamers to randomly cycle through
streamer_list = ["abney317", "Kally", "Simply", "Dowsky", "cheese", "greensuigi", "Liam"]
streamer = streamer_list[rand(1...6)].to_s
# gets data from Twitch API
request = HTTP.headers(:client_id => "pnyd2wx6lmfrsubv7jd2rmakek0g7h").auth("Bearer v3y6hy744layrep52r2hlhdj7nmgv7").get("https://api.twitch.tv/helix/search/channels?query=#{streamer}&live_only=false")
get_info = request.parse
streamer_live = false
real_streamer = false
x = 0
# cycles through the search results until the correct streamer comes up, then exit loop
while real_streamer == false
  temp = get_info["data"][x]
  if temp["display_name"] == "#{streamer}"
    real_streamer = true
    # execute additional code later if streamer is currently live
    if temp["is_live"] == true
      streamer_live = true
      game = temp["game_name"]
      time = temp["started_at"]
    else
      streamer_live = false
    end
  else
    x += 1
  end
end
if streamer_live == true
  # code for calculating how long streamer has been live based on started_at parameter.
  d = DateTime.now
  current_hour = d.strftime("%H").to_i
  # class does not transfer to UTC, so this helps the conversion be correct. Currently only correct for EST.
  if current_hour >= 19
    current_hour -= 19
  end
  current_minute = d.strftime("%M").to_i
  total_minutes_current = (current_hour * 60) + current_minute + 300
  hour = "#{time[11]}#{time[12]}".to_i
  minute = "#{time[14]}#{time[15]}".to_i
  total_minutes_streamer = (hour * 60) + minute
  minutes_streamed = total_minutes_current - total_minutes_streamer
  hours_streamed = minutes_streamed / 60
  minutes_streamed = minutes_streamed % 60
  # if hours_streamed > 1
  #   hours_plural = "hours"
  # else
  #   hours_plural = "hour"
  # end
  puts "#{streamer}: live for #{hours_streamed}h and #{minutes_streamed}m"
  puts "---"
  puts "currently playing #{game}"
else
  puts "#{streamer} is not live."
end