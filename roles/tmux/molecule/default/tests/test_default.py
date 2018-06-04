import os

import testinfra.utils.ansible_runner

# pylint: disable=C0103
testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_bashrc(host):
    ''' Checks that the tmux config file exists and is owned by the correct
        user.
    '''
    tmux_config = host.file('/home/sam/.tmux.conf')

    assert tmux_config.exists
    # TODO: Sort out a user role before enabling these!!
    # assert bashrc_file.user == 'sam'
    # assert bashrc_file.group == 'sam'


def test_bashit_installed(host):
    ''' Checks that tmux is available for use.
    '''
    bash_it_present = host.run(
        "tmux --version"
    )
    assert bash_it_present.rc == 0
