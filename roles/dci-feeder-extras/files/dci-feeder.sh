#!/bin/sh

while read line
do
  test "$line" = $'\r' && break
done

source /usr/share/dci/dcirc.sh
cd /usr/share/dci/dci-feeders
ansible-playbook -i hosts playbook.yml 2>&1 > /dev/null

echo "HTTP/1.1 200 OK"
echo "Content-Type: text/plain"
echo "Connection: close"
echo "Content-lenght: 3"
echo ""
echo "OK"
