#! /usr/bin/env python
# -*- coding: utf-8 -*-

import json
import requests
import argparse

WIDGET_URL = 'http://localhost:3030/widgets/display'


def get_users():
    users_file = open('pass/affinitic_users.json')
    users = json.load(users_file)
    users_file.close()
    return users


def get_args(allowed_users):
    parser = argparse.ArgumentParser(description="Allow to send message to the dashboard.")
    parser.add_argument('-m', '--message', required=True)
    parser.add_argument('-u', '--user', required=True,
                        choices=allowed_users)
    return parser.parse_args()


def get_token():
    myfile = open('pass/configru.json')
    myinfo = json.load(myfile)
    myfile.close()
    return myinfo['pwd']


def main():
    users = get_users()
    args = get_args(users.keys())
    token = get_token()

    messages = []
    for user in users:
        messages.append({'message': user == args.user and args.message or '',
                         'login': users[user]['nick'],
                         'user': user})

    nested_dict = {'auth_token': token,
                   'messages': messages,
                   'actualiser': args.user}

    json_object = json.dumps(nested_dict)

    headers = {'Content-Type': 'application/json', 'Accept': 'text/plain'}

    try:
        requests.post(WIDGET_URL, json_object, headers=headers)
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
