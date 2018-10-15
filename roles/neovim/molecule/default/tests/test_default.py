'''
Module to verify that neovim has been installed and configured correctly.
'''

import os
import re

import testinfra.utils.ansible_runner

# pylint: disable = invalid-name
testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')
# pylint: enable = invalid-name


def test_nvim_installed(host):
    '''
    Verify that a neovim package has been installed
    '''
    neovim_package = host.package('neovim')

    assert neovim_package.is_installed


def test_nvim_plugins_installed(host):
    '''
    Verify that we have all our nvim plugins installed.
    '''
    directory_list = [
        '/home/example',
        '/home/example/code',
        '/home/example/code/personal',
        '/home/example/code/personal/nvim',
        '/home/example/code/personal/nvim/plugged'
    ]
    for directory in directory_list:
        directory_file = host.file(directory)
        assert directory_file.is_directory

    nvim_plugins_file = host.file(
        '/home/example/code/personal/nvim/config/plugins/'
        'plug_definitions.vimrc'
    )

    plugin_file_content = nvim_plugins_file.content_string.splitlines()
    plugin_file_content = [
        line for line in plugin_file_content
        if line.startswith('Plug')
    ]
    plugin_file_content = [
        re.search(
            r"Plug\s+'(.*?)'.*",
            line
        ).group(1)
        for line in plugin_file_content
    ]

    plugged_contents = host.check_output(
        'ls -A /home/example/code/personal/nvim/plugged'
    ).splitlines()

    for plugin in plugin_file_content:
        assert plugin.split('/')[1] in plugged_contents


def test_python3_enables(host):
    # command to run: nvim --headless '+echo has("python3")' +qall
    pass
