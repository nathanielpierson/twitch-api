require 'net/http'

uri = URI('https://api.twitch.tv/helix/search/channels/')
params = {
  :query => 'abney137',
  :live_only => 'false',
}
uri.query = URI.encode_www_form(params)

req = Net::HTTP::Get.new(uri)
req['Authorization'] = 'Bearer v3y6hy744layrep52r2hlhdj7nmgv7'
req['Client-Id'] = 'pnyd2wx6lmfrsubv7jd2rmakek0g7h'

req_options = {
  use_ssl: uri.scheme == 'https'
}
res = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(req)
end
