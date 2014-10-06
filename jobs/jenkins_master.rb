require 'net/http'
require 'json'
require 'time'

myfile = File.open('pass/pwddashboard.json', 'r')
myobject = JSON.parse(myfile.read)
JENKINS_URI = URI.parse(myobject['server'])

JENKINS_AUTH = {
  'name' => myobject["login"],
  'password' => myobject["pwd"]
}

def get_json_for_master_jenkins()
    http = Net::HTTP.new(JENKINS_URI.host, JENKINS_URI.port)
    request = Net::HTTP::Get.new("/jenkins/api/json?pretty=true")

    if JENKINS_AUTH['name']
        request.basic_auth(JENKINS_AUTH['name'], JENKINS_AUTH['password'])
    end
    response = http.request(request)
    JSON.parse(response.body)
end
# the key of this mapping must be a unique identifier for your job, the according value must be the name that is specified in jenkins

SCHEDULER.every '100s', :first_in => 0 do |job|
    thom = get_json_for_master_jenkins()

send_event('master_jobs', 
    jobs: thom['jobs'][0..17]
)

end

