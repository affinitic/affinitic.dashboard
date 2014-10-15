import json
import requests
import sys


#enter trac-something

dashboard_url = "http://localhost:3030"
widget_url = dashboard_url + '/widgets/' + str(sys.argv[1])

datas = {
        "value":"3",
        "class": "blocker_tickets",
        "text": "Blocker tickets",
    }

myfile = open('pass/configru.json')
myinfo = json.load(myfile)
myfile.close()


nested_dict = {'auth_token':myinfo['pwd'],
               'item':datas}


json_object = json.dumps(nested_dict)
headers = {'Content-Type': 'application/json', 'Accept': 'text/plain'}


try:
    requests.post(widget_url, json_object, headers=headers)
    print json_object
except IOError as e:
    if hasattr(e, 'reason'):
        print "connection error:", e.reason
    elif hasattr(e, 'code'):
        print "http error:", e.code
        print e.read()
    else:
        print "error:", e

