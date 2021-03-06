import json
import requests

dashboard_url = "http://localhost:3030"
widget_url = dashboard_url + '/widgets/nouzotre'

datas = {
    "deadlines":[{
        "date": "2014-11-01",
        "name": "Finir menu",
        "status": "opened/closed",
        "contractual": "True/False",
        "url": "https://www.nouzotre.affinitic.be"
    }],
    "hoursOfWork":[{
        "login": "alain",
        "days": 0
    }]
}


def get_token():
    mynouzotre = open('pass/configru.json')
    myinfo = json.load(mynouzotre)
    mynouzotre.close()
    return myinfo['pwd']


def main():
    token = get_token()
    nested_dict = {"auth_token": token,
                "item": datas}

    json_object = json.dumps(nested_dict)
    headers = {"Content-Typer": "application/json"}

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

if __name__ == "__main__":
    main()
