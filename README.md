Check out http://shopify.github.com/dashing for more information.

To get this dashboard working, you need to:
--------------------------------------------
    -Install ruby 1.9+
    -Get some ruby gems:
        -gem 'dashing'
        -gem 'rest-client'
        -gem 'google-api-client'
        -gem 'nokogiri'
        -gem 'htmlentities'
        -gem 'httparty'
        -gem 'faraday'
    -Get some .json files:
        -pwddashboard.json with <server>, <login>, <pwd>
        -pwdgithub.json with <user>, <org>, <token>
        -pwdgoogleapi.json with <service_account_email>,<key_file>,<key_secret>,<profile_id>
        -pwdgoogleapirss.json with <service_account_email>,<key_file>,<key_secret>,<profile_id>
        -urlbitbucket.json with <url>
        -urltrac.json with <url>,<login>,<password>


If you have problem while installing nokorigi
---------------------------------------------

http://stackoverflow.com/questions/25438708/nokogiri-wont-let-me-bundle-install-in-rails
