infra.simple
============

A simple role to generically manage nodes based on inventory configuration

Requirements
------------

AWS CLI access configured to build the dynamic inventory

Role Variables
--------------

| Variable Name             | Variable Default  | Variable Description  |
|---------------------------|-------------------|-----------------------|
| simple_rhn_org_id         | ""                | Organization ID to register via RHSM|
| simple_rhn_activation_key | ""                | Activation Key to be used to RHSM register |
| simple_users              | {}                | Dictionary with user definitions |
| simple_mounts             | {}                | Dictionary with extra mount configuration |
| simple_firewalld          | {}                | Dictionary with firewalld service and port configuration |
| simple_ssh_access         | []                | List of dictionaries containing SSH public key authentication configuration |
| simple_services           | {}                | Dictionary of host-level SystemD services to control |
| simple_files              | {}                | Dictionary of files to be placed on disk |
| simple_container_subnet   | 192.168.100.0/24  | Default subnet to use for the podman service network |
| simple_containers         | {}                | Dictionary of podman containers to be configured |

License
-------

MIT
