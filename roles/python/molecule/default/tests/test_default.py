import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_python_installed(host):
    assert host.package('python2.7').is_installed
    assert host.package('python3').is_installed


def test_pipsi_installed(host):
    pipsi_file = host.file('/home/example/.local/bin/pipsi')

    assert pipsi_file.exists
    assert pipsi_file.is_symlink


def test_glances_installed(host):
    glances_file = host.file('/home/example/.local/bin/glances')

    assert glances_file.exists
    assert glances_file.is_symlink
