#!/usr/bin/python
#
# Copyright (C) 2016 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

import json
import string
import sys
import subprocess

def parse():
    if len(sys.argv) < 4:
        sys.exit('Usage: wrapper.py action login password cs-url [OPTIONS]')
    ctx = {}
    sys.argv.pop(0)
    ctx['action'] = sys.argv.pop(0)
    ctx['login'] = sys.argv.pop(0)
    ctx['password'] = sys.argv.pop(0)
    ctx['url'] = sys.argv.pop(0)
    ctx['parameters'] = sys.argv

    return ctx

def user_management(ctx):
    base_command = ['dcictl', '--dci-login', ctx['login'], '--dci-password', ctx['password'], '--dci-cs-url', ctx['url']]

    if 'list' in ctx['action']:
        command = base_command + [ctx['action']]
    elif 'create' in ctx['action']:
        command = base_command + ['--format', 'json', 'team-list']
        response = subprocess.check_output(command)
        for team in json.loads(response)['teams']:
            if team['name'] == ctx['parameters'][0]:
                team_id = team['id']
                break
        command = base_command + [ctx['action']] + ['--name', ctx['parameters'][0], '--password', ctx['parameters'][1], '--team_id', team_id ]
    elif 'update' in ctx['action']:
        command = base_command + ['--format', 'json', 'user-list']
        response = subprocess.check_output(command)
        for user in json.loads(response)['users']:
            if user['name'] == ctx['parameters'][0]:
                user_id = user['id']
                user_etag = user['etag']
                break
        command = base_command + [ctx['action']] + ['--id', user_id, '--etag', user_etag, '--name', ctx['parameters'][1]]
    elif 'delete' in ctx['action']:
        command = base_command + ['--format', 'json', 'user-list']
        response = subprocess.check_output(command)
        for user in json.loads(response)['users']:
            if user['name'] == ctx['parameters'][0]:
                user_id = user['id']
                user_etag = user['etag']
                break
        command = base_command + [ctx['action']] + ['--id', user_id, '--etag', user_etag]

    return command


def team_management(ctx):
    base_command = ['dcictl', '--dci-login', ctx['login'], '--dci-password', ctx['password'], '--dci-cs-url', ctx['url']]

    if 'list' in ctx['action']:
        command = base_command + [ctx['action']]
    elif 'create' in ctx['action']:
        command = base_command + [ctx['action']] + ['--name', ctx['parameters'][0]]
    elif 'update' in ctx['action']:
        command = base_command + ['--format', 'json', 'team-list']
        response = subprocess.check_output(command)
        for team in json.loads(response)['teams']:
            if team['name'] == ctx['parameters'][0]:
                team_id = team['id']
                team_etag = team['etag']
                break
        command = base_command + [ctx['action']] + ['--id', team_id, '--etag', team_etag, '--name', ctx['parameters'][1]]
    elif 'delete' in ctx['action']:
        command = base_command + ['--format', 'json', 'team-list']
        response = subprocess.check_output(command)
        for team in json.loads(response)['teams']:
            if team['name'] == ctx['parameters'][0]:
                team_id  = team['id']
                team_etag  = team['etag']
                break
        command = base_command + [ctx['action']] + ['--id', team_id, '--etag', team_etag]

    return command


def test_management(ctx):
    base_command = ['dcictl', '--dci-login', ctx['login'], '--dci-password', ctx['password'], '--dci-cs-url', ctx['url']]

    if 'list' in ctx['action']:
        command = base_command + [ctx['action']]
    elif 'create' in ctx['action']:
        command = base_command + [ctx['action']] + ['--name', ctx['parameters'][0]]
    elif 'update' in ctx['action']:
        command = base_command + ['--format', 'json', 'test-list']
        response = subprocess.check_output(command)
        for test in json.loads(response)['tests']:
            if test['name'] == ctx['parameters'][0]:
                test_id = test['id']
                test_etag = test['etag']
                break
        command = base_command + [ctx['action']] + ['--id', test_id, '--etag', test_etag, '--name', ctx['parameters'][1]]
    elif 'delete' in ctx['action']:
        command = base_command + ['--format', 'json', 'test-list']
        response = subprocess.check_output(command)
        for test in json.loads(response)['tests']:
            if test['name'] == ctx['parameters'][0]:
                test_id  = test['id']
                test_etag  = test['etag']
                break
        command = base_command + [ctx['action']] + ['--id', test_id, '--etag', test_etag]

    return command


def remoteci_management(ctx):
    base_command = ['dcictl', '--dci-login', ctx['login'], '--dci-password', ctx['password'], '--dci-cs-url', ctx['url']]

    if 'list' in ctx['action']:
        command = base_command + [ctx['action']]
    elif 'create' in ctx['action']:
        command = base_command + ['--format', 'json', 'team-list']
        response = subprocess.check_output(command)
        for team in json.loads(response)['teams']:
            if team['name'] == ctx['parameters'][1]:
                team_id = team['id']
                break
        command = base_command + [ctx['action']] + ['--name', ctx['parameters'][0], '--team_id', team_id ]
    elif 'update' in ctx['action']:
        command = base_command + ['--format', 'json', 'remoteci-list']
        response = subprocess.check_output(command)
        for remoteci in json.loads(response)['remotecis']:
            if remoteci['name'] == ctx['parameters'][0]:
                remoteci_id = remoteci['id']
                remoteci_etag = remoteci['etag']
                break
        command = base_command + [ctx['action']] + ['--id', remoteci_id, '--etag', remoteci_etag, '--name', ctx['parameters'][1]]
    elif 'delete' in ctx['action']:
        command = base_command + ['--format', 'json', 'remoteci-list']
        response = subprocess.check_output(command)
        for remoteci in json.loads(response)['remotecis']:
            if remoteci['name'] == ctx['parameters'][0]:
                remoteci_id = remoteci['id']
                remoteci_etag = remoteci['etag']
                break
        command = base_command + [ctx['action']] + ['--id', remoteci_id, '--etag', remoteci_etag]

    return command


def route(ctx):
    if 'user' in ctx['action']:
        command = user_management(ctx)
    elif 'team' in ctx['action']:
        command = team_management(ctx)
    elif 'test' in ctx['action']:
        command = test_management(ctx)
    elif 'remoteci' in ctx['action']:
        command = remoteci_management(ctx)

    print subprocess.check_output(command)


def main():
    ctx = parse()
    route(ctx)


if __name__ == "__main__":
  main()
