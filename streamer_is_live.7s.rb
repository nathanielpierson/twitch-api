#!/usr/bin/env /Users/nathanielpierson/.rbenv/shims/ruby
require 'http'
# array of streamers to randomly cycle through
streamer_list = ["abney317", "Kally", "MarineMammalRescue", "Zfg1", "Simply", "Dowsky", "cheese", "greensuigi", "Liam", "karinpune"]

# this line makes it so you don't have to change values in the rng when you add or remove from array.
streamer_number = streamer_list.length
streamer = streamer_list[rand(0...streamer_number)].to_s
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

d = DateTime.now
current_day = (d.strftime("%D")[3] + d.strftime("%D")[4]).to_i
if streamer_live == true
  # code for calculating how long streamer has been live based on started_at parameter.
  current_hour = d.strftime("%H").to_i + 5
  # class does not transfer to UTC, so this helps the conversion be correct. Currently only correct for EST.
  if current_hour >= 24
    current_hour -= 24
  end
  current_minute = d.strftime("%M").to_i
  total_minutes_current = (current_hour * 60) + current_minute
  day = "#{time[8]}#{time[9]}".to_i
  hour = "#{time[11]}#{time[12]}".to_i
  minute = "#{time[14]}#{time[15]}".to_i
  total_minutes_streamer = (hour * 60) + minute
  minutes_streamed = total_minutes_current - total_minutes_streamer
  hours_streamed = minutes_streamed / 60
  minutes_streamed = minutes_streamed % 60
  days_streamed = current_day - day

  # shows minutes streamed if live for under an hour
  if hours_streamed < 1 && days_streamed == 0
    if streamer.length > 9
      shortened_streamer = streamer.split("")
      while shortened_streamer.length > 9
        shortened_streamer.pop
      end
      puts "#{shortened_streamer.join()}: live for #{minutes_streamed} minutes"
    else
      puts "#{streamer}: live for #{minutes_streamed} minutes"
    end
  elsif
    # shows both minutes and hours once stream has been live for an hour
    days_streamed == 0 
    puts "#{streamer}: live for #{hours_streamed}h and #{minutes_streamed}m"
  else
    # for streams live longer than an hour, shortens streamer name to fit in Xbar if it's longer than 6 characters and includes days
    if streamer.length > 6
      shortened_streamer = streamer.split("")
      while shortened_streamer.length > 6
        shortened_streamer.pop
      end
      puts "#{shortened_streamer.join()}: live for #{days_streamed}d, #{hours_streamed}h, #{minutes_streamed}m"
    else
      puts "#{streamer}: live for #{days_streamed}d, #{hours_streamed}h and #{minutes_streamed}m"
    end
  end
  puts "---"
  puts "currently playing #{game}"
else
  puts "#{streamer} is not live."
end