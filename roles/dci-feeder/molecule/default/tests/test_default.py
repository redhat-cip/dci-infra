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
