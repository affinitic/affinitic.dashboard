affinitic.dashboard:
---------------------

With the affinitic.dashboard, you'll get all you need to manage your servers and development tools.
This include:

*   The last commit on Github
*   The last commit on Bitbucket
*   A graph displaying the number of visitor of any given website you rules
*   The last jenkins build you've done
*   A magnificent clock
*   A graph displaying the important informations of your server
*   A camera widget


To get this dashboard working, you need to:
--------------------------------------------

*   Install ruby 1.9+
*   Get some ruby gems:
    *   `sudo gem install dashing`
    *   `sudo gem install rest-client`
    *   `sudo gem install google-api-client`
    *   `sudo gem install nokogiri`
    *   `sudo gem install htmlentities`
    *   `sudo gem install faraday`
    *   `sudo gem install httparty`
    *   `sudo gem install bundler`

*   After installing all the gems, do: `bundle install --path=. --binstubs`

*   sudo apt-get install nodejs
*   Get some .json files
    
    If you get an Ruby error, try this: http://stackoverflow.com/questions/11058952/why-do-i-get-an-error-installing-the-json-gem-in-ubuntu

*   Define the passwords files, or import it from production:
    `rsync -av dashboard.affinitic.be:/home/dashing/pass .`

To start the dashboard:
-----------------------

Run::

  bin/dashing start


Continuous deployment
---------------------

In our jenkins: http://jenkins.affinitic.be/jenkins/job/affinitic-dashing-deb/


If you have problem while installing nokorigi
---------------------------------------------

http://stackoverflow.com/questions/25438708/nokogiri-wont-let-me-bundle-install-in-rails


Need more information ?
-----------------------

Check out http://shopify.github.com/dashing.
