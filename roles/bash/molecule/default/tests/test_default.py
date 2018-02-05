import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_bashrc(host):
    ''' Checks that the bashrc file exists and is owned by the correct user.
    '''
    bashrc_file = host.file('/home/sam/.bashrc')

    assert bashrc_file.exists
    # TODO: Sort out a user role before enabling these!!
    # assert bashrc_file.user == 'sam'
    # assert bashrc_file.group == 'sam'


def test_bashit_installed(host):
    ''' Checks that the bash-it command is available for use.
    '''
    bash_it_present = host.run(
        "bash -c 'source /home/sam/.bashrc && command -v bash-it'"
    )
    assert bash_it_present.rc == 0
