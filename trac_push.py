import json
import requests

dashboard_url = "http://localhost:3030"
widget_url = dashboard_url + '/widgets/trac'

datas = [
    {
        "value":"1",
        "class": "blocker_tickets",
        "text": "Blocker tickets",
    },
    {
        "value":"5",
        "class":"opened_today",
        "text":"Opened today",
    },
    {
        "value":"3",
        "class":"closed_today",
        "text":"Closed today",
    },
]

nested_dict = {'auth_token':"blablabla12345",
               'items':datas}

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



blocker_count =0
open_count = 0
closed_count = 0

for i in range(len(datas)):
    if datas[i]['value'] == 'critical_tickets()':
        blocker_count+=1
    if datas[i]['value'] == 'closed_tickets()':
        closed_count+=1
    if datas[i]['value'] == 'opened_tickets()':
        open_count+=1

print 'blocker_count = ' + str(blocker_count)
print 'open_count = ' + str(open_count)
print 'closed_count = ' + str(closed_count)

