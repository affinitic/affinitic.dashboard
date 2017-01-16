import json
import requests
import argparse


# enter trac-something

def get_args():
    parser = argparse.ArgumentParser(description='You need to add some arguments here.')
    parser.add_argument('-t', '--tracname', required=True, choices=['trac-merged'])
    parser.add_argument('--arsiavalue', type=str, required=True)
    parser.add_argument('--affiniticvalue', type=str, required=True)
    parser.add_argument('--sprbvalue', type=str, required=True)
    parser.add_argument('--cirbvalue', type=str, required=True)

    print parser.parse_args()
    return parser.parse_args()

args = get_args()

dashboard_url = "http://localhost:3030"
widget_url = dashboard_url + '/widgets/' + args.tracname


datas = {"arsia": {"value": args.arsiavalue,
                   "class": "blocker_tickets",
                   "href": "http://trac.arsia.affinitic.be/trac/query?priority=blocker&status=in+analysis&status=in+development&status=in+testing&status=new&status=ready+for+production&status=reopened&col=id&col=summary&col=priority&col=owner&col=type&col=status&col=milestone&order=priority"},
         "affinitic": {"value": args.affiniticvalue,
                       "class": "blocker_tickets",
                       "href": "http://trac.affinitic.be/trac/query?priority=blocker&status=accepted&status=assigned&status=new&status=reopened&col=id&col=summary&col=status&col=type&col=priority&col=severity&col=time&order=priority&report=7"},
         "SPRB": {
             "value": args.sprbvalue,
             "class": "blocker_tickets",
             "href": "http://trac.sprb.affinitic.be/trac/query?priority=blocker&status=accepted&status=assigned&status=new&status=reopened&col=id&col=summary&col=status&col=type&col=priority&col=severity&col=time&order=priority&report=7"},
         "CIRB": {
             "value": args.cirbvalue,
             "class": "blocker_tickets",
             "href": "http://trac.cirb.affinitic.be/trac/query?priority=blocker&status=accepted&status=assigned&status=new&status=reopened&col=id&col=summary&col=status&col=type&col=priority&col=severity&col=time&order=priority&report=7"}}


for client in datas:
    if datas[client]['value'] == '0':
        datas[client]['class'] = 'alright'
        datas[client]['text'] = 'No problem'

myfile = open('pass/configru.json')
myinfo = json.load(myfile)
myfile.close()


nested_dict = {'auth_token': myinfo['pwd'],
               'item': datas}


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
