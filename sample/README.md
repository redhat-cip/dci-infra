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
heat stack-create dci -f heat-platform.hot -P key_name=YOURKEYNAME -P private_net_id=0577b35c-6861-45d4-87f8-fd154297096f -P public_net_id=0f25616e-387f-49c5-9b4c-abaefc1d1c12 -P webapp_fip_id=92979f4c-8e4e-420a-98e5-c98a0cc7b67b -P db_fip_id=98c463db-b51a-4b05-b171-9d5d73d597a4 -P es_fip_id=d722a1b5-dd13-43c8-b3e3-732152cc0288 -P api_fip_id=d8749d60-01f1-46df-8292-3c6b8f2793f3 -P monitor_fip_id=fa4cebb6-7003-4a66-946d-d45f5e002df5
```

Webapp -> 46.231.133.47
db -> 46.231.133.46
es -> 46.231.133.45
api -> 46.231.133.44
monitor -> 46.231.133.36
