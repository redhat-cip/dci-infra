#!/bin/python

from optparse import OptionParser
from os import listdir

import os
import json
import zmq
import time

def main():

    context = zmq.Context()
    socket = context.socket(zmq.PUB)
    socket.connect("tcp://localhost:7777")

    while True:
        if len(listdir('/var/tmp/sensu_alerts')) > 0:
            for file in listdir('/var/tmp/sensu_alerts'):
                time.sleep(1)
                filepath = '/var/tmp/sensu_alerts/%s' % file
                json_content = json.load(open(filepath, 'r'))
                json_content['dcid'] = 'dci'
                socket.send(json.dumps({'sensu': json_content}))
                time.sleep(2)
                os.remove(filepath)

main()

