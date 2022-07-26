dci.certbot
===========

A very simplified role to manage LetsEncrypt certs with CertBot for DCI.

Inspired by
- https://galaxy.ansible.com/geerlingguy/certbot
- https://galaxy.ansible.com/michaelpporter/certbot_cloudflare

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Main role:
- certbot_user: (optional) User running certbot. defaults to `ansible_user`
- certbot_group: (optional) Group running certbot. defaults to `ansible_user`
- certbot_cron_minute: (optional) Renewal time (minute). defaults to `36`
- certbot_cron_hour: (optional) Renewal time (hour). defaults to `3`

- certbot_email: (optional) a registeration email to receive important information related to certificates. If not defined, will register without email (not recommended).

certbot-dns-ovh (see https://certbot-dns-ovh.readthedocs.io/en/stable/ for more info)
- certbot_dns_ovh_endpoint: (optional) For OVH DNSAPI, regional endpoint. defaults to `ovh-eu`
- certbot_dns_ovh_application_key: (mandatory)
- certbot_dns_ovh_application_secret: (mandatory)
- certbot_dns_ovh_consumer_key: (mandatory).


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: ssl_host
      roles:
         - role: dci.certbot # Will install certbot
           vars:
             certbot_user: certbot
             certbot_group: certbot
             certbot_cron_minute: 47
             cerbot_cron_hour: 9
             certbot_dns_ovh_endpoint: ovh-eu
             certbot_dns_ovh_application_key: appkey
             certbot_dns_ovh_application_secret: appsecret
             certbot_dns_ovh_consumer_key: consumkey
         - role: dci.certbot
           tasks_from: cert
           vars:
             certbot_domains: ['example.com', 'www.example.com']
         - role: dci.certbot
           tasks_from: cert
           vars:
             certbot_domains: 'worker*.example.com'

License
-------

Apache-2.0

Author Information
------------------

Contact: distributed-ci@redhat.com
