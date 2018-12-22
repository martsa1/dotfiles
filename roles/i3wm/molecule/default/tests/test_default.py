import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_hosts_file(host):
    """
    Ensure we have an i3 config in place.
    """
    with host.sudo():
        host.run_expect([0], 'test -d /home/example/.config/i3')
        host.run_expect([0], 'test -L /home/example/.config/i3')
        host.run_expect([0], 'test -e /home/example/.config/i3/config')


def test_tmux_installed(host):
    ''' Checks that tmux is available for use.
    '''
    i3wm_installed = host.run(
        "i3 --version"
    )
    assert i3wm_installed.rc == 0
    assert 'i3 version 4' in i3wm_installed.stdout
