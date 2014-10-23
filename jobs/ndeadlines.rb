require 'net/http'
require 'json'
require 'time'

myfile = File.open('pass/getnouzotrejson.json', 'r')
myobject = JSON.parse(myfile.read)
NOUZOTRE_URI = URI.parse(myobject['server'])

NOUZOTRE_AUTH ||= {
  'name' => myobject["login"],
  'password' => myobject["pass"]
}

def get_json_for_nouzotreDeadlines()
    http = Net::HTTP.new(NOUZOTRE_URI.host, NOUZOTRE_URI.port)
    request = Net::HTTP::Get.new("/next-deadlines-json")

    if NOUZOTRE_AUTH['name']
        request.basic_auth(NOUZOTRE_AUTH['name'], NOUZOTRE_AUTH['password'])
    end
    response = http.request(request)
    JSON.parse(response.body)
end
## the key of this mapping must be a unique identifier for your job, the according value must be the name that is specified in jenkins

SCHEDULER.every '100s', :first_in => 0 do |deadline|
    deadlines = get_json_for_nouzotreDeadlines()

    deadlineOpen = []
    
    deadlines.each do |deadline|
        if deadline['closed'] == false
            if deadline['contractual'] == true 
                deadline['css']= 'contractual'
            end
            deadlineOpen.push(deadline)
        end
    end

    send_event('ndeadlines',
        deadline:deadlineOpen
    )
end
