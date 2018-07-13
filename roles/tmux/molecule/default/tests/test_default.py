import os

import testinfra.utils.ansible_runner

# pylint: disable=C0103
testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_tmux_conf(host):
    ''' Checks that the tmux config file exists and is owned by the correct
        user.
    '''
    tmux_config = host.run(
        "sudo ls /home/example/.tmux.conf"
    )
    assert tmux_config.rc == 0


def test_tmux_installed(host):
    ''' Checks that tmux is available for use.
    '''
    tmux_installed = host.run(
        "tmux -V"
    )
    assert tmux_installed.rc == 0
    assert tmux_installed.stdout == 'tmux 2.7'
