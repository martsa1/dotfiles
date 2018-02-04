''' Test suite for Dotfiles Ansible Role
'''

import os

import testinfra.utils.ansible_runner

# pylint: disable= C0103
testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_user_dotfiles_dir(host):
    ''' Checks that the dotfiles directory is created.
    '''
    dotfiles_directory = host.file('/home/root/code/personal/dotfiles/')

    assert dotfiles_directory.exists
    assert dotfiles_directory.is_directory
