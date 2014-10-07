require 'google/api_client'
require 'date'


class GoogleAnalytics
# Start the scheduler
    def initialize(json_path, client_name)
        @visitors = []

        myfile = File.open(json_path, 'r')
        @myinfo = JSON.parse(myfile.read)

        @client = Google::APIClient.new(
          :application_name => client_name,
          :application_version => '0.01'
        )
    end

    def GetVisitors()

        service_account_email = @myinfo['service_account_email'] #Email of service account
        key_file = @myinfo['key_file'] # File containing your private key
        key_secret = @myinfo['key_secret'] # Password to unlock private key
        profile_id = @myinfo['profile_id'] # AnalYtics profile ID.-55151386-1

        # Load your credentials for the service account
        key = Google::APIClient::KeyUtils.load_from_pkcs12(key_file, key_secret)
        @client.authorization = Signet::OAuth2::Client.new(
          :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
          :audience => 'https://accounts.google.com/o/oauth2/token',
          :scope => 'https://www.googleapis.com/auth/analytics.readonly',
          :issuer => service_account_email,
          :signing_key => key)
          # Request a token for our service account
          @client.authorization.fetch_access_token!

        # Get the analytics API
        analytics = @client.discovered_api('analytics','v3')


        # Execute the query
        response = @client.execute(:api_method => analytics.data.realtime.get, :parameters => {
        'ids' => "ga:" + profile_id,
        'metrics' => "ga:activeVisitors",
        })

        visitors_int = 0

        if response.data.rows.nil?
            puts "No google data found"
        else
            visitors_int = response.data.rows[0][0].to_i
        end


        @visitors << { x: Time.now.to_i, y: visitors_int }
        if @visitors.length > 10 then
          @visitors.delete(0)
        end

        return @visitors
        puts @visitors
    end
end
