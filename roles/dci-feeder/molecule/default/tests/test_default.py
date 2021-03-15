"""Role testing files using testinfra."""


def test_hosts_file(host):
    """Validate /etc/hosts file."""
    f = host.file("/etc/hosts")

    assert f.exists
    assert f.user == "root"
    assert f.group == "root"


def test_feeder_packages_installed(host):
    assert host.package("dci-feeder-api").is_installed
    assert host.package("dci-umb").is_installed


def test_httpd_is_running(host):
    assert host.service("httpd").is_enabled
    assert host.service("httpd").is_running

    assert host.socket("tcp://0.0.0.0:80").is_listening


def test_httpd_enabled_feeder_api(host):
    assert (
        host.command(
            "curl --silent -H feeder.distributed-ci.io http://127.0.0.1/"
        ).stdout
        == '{"_status": "OK", "message": "Distributed CI Feeder as a Service. '
        'GET /options to see available options"}'
    )


def test_dci_umb_is_running(host):
    assert host.service("dci-umb").is_enabled
    # Can't verify that the service is running because of required SSL certs &
    # valid AMQP endpoint
    # assert host.service("dci-umb").is_running


def test_docker_packages(host):
    assert host.package("docker").is_installed
    assert host.package("python-docker-py").is_installed
    assert host.package("python-docker-py").version.startswith("1.10")
    assert not host.package("python-docker").is_installed


def test_yum_config_obsoletes(host):
    f = host.file("/etc/yum.conf")

    assert f.exists
    assert f.contains("^obsoletes *= *0$")


def test_dci_feeder_api_local_settings(host):
    f = host.file("/etc/dci-feeder-api/local_settings.py")

    assert f.exists
    assert f.contains("^DCI_CS_URL = 'https://dci-api.example.com'$")
    assert f.contains("^DCI_CLIENT_ID = 'feeder/1234567890'$")
    assert f.contains("^DCI_API_SECRET = 'ssssssecretttttt'$")
    assert f.contains("^DCI_REPO_RSYNC_TARGET = "
                      "'dci-repo.example.com:/data/dci_repo'$")
    assert f.contains("^DEST_REGISTRY_USER = 'reguser'$")
    assert f.contains("^DEST_REGISTRY_PASSWORD = 'regpasswd'$")


def test_dci_feeder_api_cache_folder(host):
    f = host.file("/var/cache/dci-feeder-api")
    assert f.exists
    assert f.is_directory
    assert f.user == "dci"
    assert f.group == "dci"
    assert f.mode == 0o755
