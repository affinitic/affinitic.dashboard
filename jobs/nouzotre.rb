require 'net/http'
require 'json'
require 'time'
require 'digest'

myfile = File.open('pass/getnouzotrejson.json', 'r')
myobject = JSON.parse(myfile.read)
NOUZOTRED_URI_NOUZOTRE = URI.parse(myobject['server'])

NOUZOTRE_AUTH_NOUZOTRE ||= {
  'name' => myobject["login"],
  'password' => myobject["pass"]
}

def get_json_for_nouzotre()
    http = Net::HTTP.new(NOUZOTRED_URI_NOUZOTRE.host, NOUZOTRED_URI_NOUZOTRE.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new("/last-encodages-json")

    if NOUZOTRE_AUTH_NOUZOTRE['name']
        request.basic_auth(NOUZOTRE_AUTH_NOUZOTRE['name'], NOUZOTRE_AUTH_NOUZOTRE['password'])
    end
    response = http.request(request)
    JSON.parse(response.body)
end

SCHEDULER.every '100s', :first_in => 0 do
    lastEncodage = get_json_for_nouzotre()
    notEncodedWorker = []

    lastEncodage.each do |badworker|
        if badworker['days'] >= 2
            email = badworker['email']
            gravatar_id = Digest::MD5.hexdigest(email.downcase)
            badworker['picture'] = 'http://www.gravatar.com/avatar/' + gravatar_id + '.jpg'
            notEncodedWorker.push(badworker)
        end
    end

    badworkerSorted = notEncodedWorker.sort_by{|k| k['days']}.reverse
    chosenOnes = badworkerSorted[0..3]

    send_event('nouzotre',
        badworker:chosenOnes
    )
end
