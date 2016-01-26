#!/bin/sh
#
# Copyright 2016 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# Mandatory parameters to pass in the command line
#
action=$1
dci_login=$2
shift
dci_password=$2
shift
dci_cs_url=$2
shift


case $action in
  'team-list')
    dcictl --dci-login=${dci_login} --dci-password=${dci_password} --dci-cs-url=${dci_cs_url} team-list
  ;;
  'team-create')
    dcictl --dci-login=${dci_login} --dci-password=${dci_password} --dci-cs-url=${dci_cs_url} team-create --name ${2}
  ;;
  'team-update')
    list_result="$(dcictl --dci-login=${dci_login} --dci-password=${dci_password} --dci-cs-url=${dci_cs_url} team-list)"
    current_result=$(echo "${list_result}" | grep -E "\|\s*${2}\s*\|")
    actual_command=$(echo "${current_result}" | sed s"#|\s*\(.*\)\s*|\s*${2}\s*|\s*\([^|]*\).*#dcictl --dci-login=${dci_login} --dci-password=${dci_password} --dci-cs-url=${dci_cs_url} team-update --id \1--etag \2 --name ${3}#g")
    $actual_command
  ;;
  'team-delete')
    list_result="$(dcictl --dci-login=${dci_login} --dci-password=${dci_password} --dci-cs-url=${dci_cs_url} team-list)"
    current_result=$(echo "${list_result}" | grep -E "\|\s*${2}\s*\|")
    actual_command=$(echo "${current_result}" | sed s"#|\s*\(.*\)\s*|\s*${2}\s*|\s*\([^|]*\).*#dcictl --dci-login=${dci_login} --dci-password=${dci_password} --dci-cs-url=${dci_cs_url} team-delete --id \1--etag \2#g")
    $actual_command
  ;;
  *)
    echo "wrapper.sh: ${action} this command does not exist"
    exit 1
esac
