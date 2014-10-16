#! /usr/bin/env python
# -*- coding: utf-8 -*-

import os
import json
import requests
import argparse

WIDGET_URL = 'http://localhost:3030/widgets/display'


def get_args():
    help_message = """
    Allow to send message to the dashboard.
    Nickname will take your shell user by default.
    """
    parser = argparse.ArgumentParser(description=help_message)
    parser.add_argument('-m', '--message', required=True)
    parser.add_argument('-n', '--nickname', required=False, help="Use shell user by default")
    return parser.parse_args()


def get_token():
    myfile = open('pass/configru.json')
    myinfo = json.load(myfile)
    myfile.close()
    return myinfo['pwd']


def main():
    args = get_args()
    token = get_token()

    user = args.nickname or os.getenv('USER')

    nested_dict = {'auth_token': token,
                   'message': args.message,
                   'nickname': user}

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
