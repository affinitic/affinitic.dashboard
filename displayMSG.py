import json
import requests

dashboard_url = "http://localhost:3030"
widget_url = dashboard_url + '/widgets/display'

thom = raw_input('Entrez votre message: ')
nested_dict = {'auth_token' : 'blablabla12345',
               'message':thom}

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