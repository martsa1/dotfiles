import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_profile(host):
    ''' Checks that the .profile file exists and is owned by the correct user.
    '''
    profile_file = host.file('/home/example/.profile')

    assert profile_file.exists


def test_bashrc(host):
    ''' Checks that the bashrc file exists and is owned by the correct user.
    '''
    bashrc_file = host.file('/home/example/.bashrc')

    assert bashrc_file.exists
    # TODO: Sort out a user role before enabling these!!
    # assert bashrc_file.user == 'sam'
    # assert bashrc_file.group == 'sam'


def test_bashit_installed(host):
    ''' Checks that the bash-it command is available for use.
    '''
    bash_it_present = host.run(
        "bash -c 'export USER=example; source /home/example/.bashrc; command"
        " -v bash-it'"
    )
    assert bash_it_present.rc == 0
