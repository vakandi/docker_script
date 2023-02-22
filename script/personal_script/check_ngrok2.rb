require 'httparty'

# get ngrok public url
begin
  response = HTTParty.get 'http://localhost:4040/api/tunnels'
  json = JSON.parse response.body
  new_sms_url = json['tunnels'].first['public_url']
rescue Errno::ECONNREFUSED
  print 'no ngrok instance found. shutting down'
  exit
end
