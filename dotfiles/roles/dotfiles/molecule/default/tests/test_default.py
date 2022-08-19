''' Test suite for Dotfiles Ansible Role
'''

import os

import testinfra.utils.ansible_runner

# pylint: disable= C0103
testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_user_dotfiles_root_dir(host):
    ''' Checks that the dotfiles directory is created.
    '''
    dotfiles_base_dir = host.run(
        "sudo ls /home/example/code/personal"
    )
    assert dotfiles_base_dir.rc == 0


def test_dotfiles_clone(host):
    ''' Checks that a dotfiles git repo was successfully cloned into the
        appropriate default location.
    '''
    dotfiles_base_dir = host.run(
        "sudo ls /home/example/code/personal/dotfiles/.git"
    )
    assert dotfiles_base_dir.rc == 0
