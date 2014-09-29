require 'google/api_client'
require 'date'

# Update these to match your own apps credentials
service_account_email = '148511232865-0okif4mgdrgabroc08q30umv98umqepj@developer.gserviceaccount.com' # Email of service account
key_file = '/home/bruyer/Bureau/756e2f003cc9.p12' # File containing your private key
key_secret = 'notasecret' # Password to unlock private key
profileID = 'UA-55151386-1' # AnalYtics profile ID.-55151386-1

# Get the Google API client
client = Google::APIClient.new(
  :application_name => '[YOUR APPLICATION NAME]', 
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
SCHEDULER.every '10m', :first_in => 0 do

  # Request a token for our service account
  client.authorization.fetch_access_token!

  # Get the analytics API
  analytics = client.discovered_api('analytics','v3')

  # Execute the query
  visitCount = client.execute(:api_method => analytics.data.realtime.get, :parameters => { 
    'ids' => "ga:" + profile_id,
    'metrics' => "ga:activeVisitors",
  })

  visitors << { x: Time.now.to_i, y: visits.to_i }

  # Update the dashboard
  send_event('visitor_count_real_time', points: visitors)
end
