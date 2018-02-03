''' Test suite for Dotfiles Ansible Role
'''

import os

import testinfra.utils.ansible_runner

# pylint: disable= C0103
testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_hosts_file(host):
    ''' Sample test to check the hosts file exists.
    '''
    f = host.file('/etc/hosts')

    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'
