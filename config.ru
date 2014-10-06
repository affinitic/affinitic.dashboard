require 'dashing'

configure do
    
    myfile = File.open('pass/configru.json', 'r')
    myinfo = JSON.parse(myfile.read)

    set :auth_token, myinfo['pwd']

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
