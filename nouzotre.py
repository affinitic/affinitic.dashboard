import json
import requests

dashboard_url = "http://localhost:3030"
widget_url = dashboard_url + '/widgets/nouzotre'

datas ={
    "milestone":{
        "prestation":"bonjour",
        "date":"10 03 2018",
        "deadlines":"Blocker tickets",
        "photo":"assets/logo.png"
        }
}

mynouzotre = open('pass/nouzotre.json')
test = json.load(mynouzotre)
mynouzotre.close()


nested_dict = {"auth_token":test["pwd"],
               "item":datas}


json_object = json.dumps(nested_dict)
headers = {"Content-Typer": "application/json" }


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
