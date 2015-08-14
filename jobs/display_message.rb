require 'date'
require 'net/http'
require 'json'
require 'time'

myfile = File.open('pass/getnouzotrejson.json', 'r')
myobject = JSON.parse(myfile.read)
NOUZOTRE_URI_DISPLAY = URI.parse(myobject['server'])

NOUZOTRE_AUTH_DISPLAY ||= {
  'name' => myobject["login"],
  'password' => myobject["pass"]
}

def get_json_for_nouzotre_dashboard_messages()
    http = Net::HTTP.new(NOUZOTRE_URI_DISPLAY.host, NOUZOTRE_URI_DISPLAY.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new("/messages-json")

    if NOUZOTRE_AUTH_DISPLAY['name']
        request.basic_auth(NOUZOTRE_AUTH_DISPLAY['name'], NOUZOTRE_AUTH_DISPLAY['password'])
    end
    response = http.request(request)
    JSON.parse(response.body)
end

SCHEDULER.every '60s', :first_in => 0 do
    messages = get_json_for_nouzotre_dashboard_messages()

    send_event('display',
        messages:messages
    )
end
