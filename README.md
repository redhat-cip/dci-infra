# DCI Infra

Playbook and roles to deployed the DCI infrastructure.

## Usage

```console
ansible-galaxy install -r installed_roles.yml -p roles
ansible-playbook -vv playbook.yml -i <path>/hosts --tags dci-core
```

The dci-core tag will only execute a subset of the roles in order to
deploy the minimal service required.

## Roles

- common: Package update, repository setup and DCI stuff.
- dci-api: Install the DCI API (dci-control-server).
- dci-repo: Install SSL content for nginx.
- dci-ui: Install DCI WebAPP (dci-ui).
- dci-worker: Install the DCI zmq worker.
- doc: Install the DCI documentation (dci-doc).
- fail2ban: Install fail2ban and rules.
- httpd: Install and configure httpd.
- packages: Configure the DCI yum repository.
- postgresql: Install and configure postgresql.
- registry: Install and configure the container registry.
- swift: Install an AIO swift.
- elasticsearch: Install and configure the container elasticsearch.
