require 'date'
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

SCHEDULER.every '100s', :first_in => 0 do |deadline|
    deadlines = get_json_for_nouzotreDeadlines()
    deadlines = deadlines.sort { |a, b| a['date'] <=> b['date'] }

    deadlineOpen = []
    
    deadlines.each do |deadline|
        dl_date = Date.parse(deadline['date'])
        dl_date_limit = Date.today.advance(:months => 1)

        if deadline['closed'] == false && dl_date < dl_date_limit
            if deadline['contractual'] == true 
                deadline['css']= 'contractual'
            end
            deadline['date'] = dl_date.strftime('%d-%m-%Y')
            deadlineOpen.push(deadline)
        end
    end

    send_event('ndeadlines',
        deadline:deadlineOpen
    )
end
