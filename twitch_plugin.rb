require 'http'
puts "hello"
request = HTTP.headers(:client_id => "pnyd2wx6lmfrsubv7jd2rmakek0g7h").auth("Bearer v3y6hy744layrep52r2hlhdj7nmgv7").get("https://api.twitch.tv/helix/search/channels?query=abney317&live_only=false")
get_info = request.parse(:json)
realabney = false
x = 0
while realabney == false
  temp = get_info["data"][x]
  if temp["display_name"] == "abney317"
    realabney = true
    if temp["is_live"] == true
      abney_live = true
    else
      abney_live = false
    end
  else
    x += 1
    # p x
    # p temp["display_name"]
  end
end
if abney_live == true
  puts "Abney is live"
else
  puts "Abney is not live."
end