How to use it
=============

Openrc
------

Source a file with the following content:

```
export OS_USERNAME=YOURUSERNAME
export OS_PASSWORD=YOURPASSWORD
export OS_TENANT_NAME='DCI-Prod'
export OS_AUTH_URL=http://rcip-dev.ring.enovance.com:35357/v2.0
```

Heat command
------------

Run the following heat command:

```
heat stack-create dci -f heat-platform.hot -P key_name=YOURKEYNAME -P private_net_id=0577b35c-6861-45d4-87f8-fd154297096f -P public_net_id=0f25616e-387f-49c5-9b4c-abaefc1d1c12
```
