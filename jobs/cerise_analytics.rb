require 'google/api_client'
require 'date'
#
#
#CERISE
#
#
myfile = File.open('../pwdgoogleapi.json', 'r')
myinfo = JSON.parse(myfile.read)


service_account_email = myinfo['service_account_email'] #Email of service account
key_file = myinfo['key_file'] # File containing your private key
key_secret = myinfo['key_secret'] # Password to unlock private key
profile_id = myinfo['profile_id'] # AnalYtics profile ID.-55151386-1



# Get the Google API client
client = Google::APIClient.new(
  :application_name => 'ARSIA',
  :application_version => '0.01'
)

visitors = []

# Load your credentials for the service account
key = Google::APIClient::KeyUtils.load_from_pkcs12(key_file, key_secret)
client.authorization = Signet::OAuth2::Client.new(
  :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
  :audience => 'https://accounts.google.com/o/oauth2/token',
  :scope => 'https://www.googleapis.com/auth/analytics.readonly',
  :issuer => service_account_email,
  :signing_key => key)


# Start the scheduler
SCHEDULER.every '10s', :first_in => 0 do
  # Request a token for our service account
  client.authorization.fetch_access_token!

  # Get the analytics API
  analytics = client.discovered_api('analytics','v3')


  # Execute the query
  response = client.execute(:api_method => analytics.data.realtime.get, :parameters => {
    'ids' => "ga:" + profile_id,
    'metrics' => "ga:activeVisitors",
  })

  visitors << { x: Time.now.to_i, y: response.data.rows[0][0].to_i }
  # Update the dashboard
  if visitors.length > 10 then
    visitors.delete_at(0)
  end
  send_event('visitor_count_real_time', points: visitors)
  #puts "ehello"
 # puts visitors.length
 # puts response.error_message
end
