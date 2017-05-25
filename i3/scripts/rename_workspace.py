#!/usr/bin/env python3
''' Small script to dynamically update the name of an i3wm workspace
'''

import json
import logging
import sys
from subprocess import check_output, CalledProcessError, DEVNULL

MOD_KEY = 'Mod4'
LOG_FORMAT_STRING = ('[%(asctime)s] %(levelname)s [%(name)s.%(funcName)s:%'
                     '(lineno)d] %(message)s')
logging.basicConfig(
    format=LOG_FORMAT_STRING,
    datefmt='%Y-%m-%d %H:%M:%S',
    level=logging.DEBUG
)
LOGGER = logging.getLogger(__name__)


def get_workspaces() -> list:
    ''' Runs a sub-process that calls to i3-msg to retrieve the workspace
        data we want to iterate over
    '''
    workspace_data = check_output([
        'i3-msg',
        '-t',
        'get_workspaces'
    ]).decode('utf8')

    workspace_data_json = json.loads(workspace_data)
    LOGGER.debug('Workspace Data: %s', workspace_data)

    return workspace_data_json


def get_active_workspace_name() -> tuple:
    ''' Parses the workspace data and returns the name & number of the
        currently active workspace
    '''
    workspace_data = get_workspaces()
    if workspace_data is None or not isinstance(workspace_data, list):
        raise TypeError('Workspace Data should be passed in as a list')

    for workspace in workspace_data:
        if workspace.get('focused'):
            # Found the current workspace, return its name and number as
            # a tuple
            LOGGER.debug(workspace)
            LOGGER.debug(type(workspace))
            LOGGER.debug('Found the active workspace: %d%s',
                         workspace.get('num'),
                         workspace.get('name'))
            return (workspace.get('name'), workspace.get('num'))


def update_workspace_name(new_workspace_name: str):
    ''' Updates the workspace name with what the user provides, prefixed
        by its existing workspace number
    '''
    if new_workspace_name is None:
        return TypeError('New Workspace Name is a required value')
    existing_workspace_name, workspace_number = (
        get_active_workspace_name()
    )

    if workspace_number is None:
        return TypeError('New Workspace Number is a required value')

    update_workspace_command = [
        'i3-msg',
        'rename',
        'workspace',
        '"{}"'.format(existing_workspace_name),
        'to',
        '"{}: {}"'.format(workspace_number, new_workspace_name)
    ]

    LOGGER.debug('Workspace Command: %s', update_workspace_command)
    update_workspace_response = check_output(update_workspace_command)
    LOGGER.debug('Workspace Response: %s', update_workspace_response)


def get_new_name() -> str:
    ''' Gets the User's new name from a zenity prompt
    '''
    new_name_command = [
        'zenity',
        '--entry',
        '--title',
        'Workspace Name',
        '--text',
        'New Workspace Name'
    ]
    try:
        new_name = check_output(new_name_command, stderr=DEVNULL)
        return new_name.decode('utf8').strip()
    except CalledProcessError:
        return None


def main():
    ''' Main module callable
    '''
    new_name = get_new_name()
    if new_name is None:
        sys.exit(0)
    update_workspace_name(new_name)


if __name__ == '__main__':
    main()
