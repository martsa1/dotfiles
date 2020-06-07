#!/usr/bin/env python3
'''
Simple module which will spawn polybar instances for primary and any secondary
monitors.
'''

import logging
import os
import re
import sys

import subprocess
from subprocess import check_call, check_output, CalledProcessError

logging.basicConfig(level=logging.INFO)
LOG = logging.getLogger(__name__)


def kill_polybar():
    '''
    Terminates any instances of polybar using the `killall` command.
    '''
    try:
        check_call(
            [
                'killall',
                'polybar'
            ]
        )

    except CalledProcessError:
        LOG.error('No Polybar instances found')


def get_monitor_info():
    '''
    Retrieves monitor configuration from `xrandr`, processes it and returns a
    list of monitor information, providing monitors along with which monitor
    xrandr considers to be primary.
    '''
    try:
        monitor_info = check_output(
            [
                'xrandr',
                '--listactivemonitors'
            ]
        )
        monitor_info = monitor_info.decode('utf-8')
        LOG.debug('Found monitors:\n%s', monitor_info)
    except CalledProcessError:
        LOG.error('Failed to retrieve monitor information')
        sys.exit(1)

    monitor_info_regex = (
        r'^\s(?P<monitor_number>\d): \+(?P<primary>\*?)(?P<monitor_name>['
        r'a-zA-Z\d-]+) (?:\d+/\d+x\d+/\d+\+)(?P<horizontal_offset>\d{0,4})\+('
        r'?P<vertical_offset>\d{0,4})\s*(?:[a-zA-Z\d-]+)$'
    )

    monitors = []
    for line in monitor_info.split('\n'):
        LOG.debug('Checking line for monitor info:\n%s', line)

        monitor_info_match = re.search(monitor_info_regex, line)

        if monitor_info_match:
            LOG.debug('Found a matching monitor: %s', monitor_info_match)
            match_details = {
                'monitor_number': monitor_info_match.group('monitor_number'),
                'is_primary': (
                    True if monitor_info_match.group('primary') else False
                ),
                'monitor_name': monitor_info_match.group('monitor_name'),
                'horizontal_offset': (
                    monitor_info_match.group('horizontal_offset')
                ),
                'vertical_offset': monitor_info_match.group('vertical_offset')
            }
            LOG.debug('Match details:\n%s', match_details)

            monitors.append(match_details)
        else:
            LOG.debug('Line failed to match')

    monitors = sorted(monitors, key=lambda x: x['monitor_number'])
    return monitors


def launch_polybars(list_of_monitors):
    '''
    Launches one or more instances of polybar.

    Requires a list of monitor information as provided by get_monitor_info.
    '''
    polybar_config_location = os.path.normpath(
        os.path.join(
            os.path.dirname(__file__),
            'config'
        )
    )

    try:
        for monitor in list_of_monitors:
            polybar_env = os.environ
            polybar_env['MONITOR'] = monitor['monitor_name']

            bar_config = (
                'primary' if monitor['is_primary'] else 'secondary'
            )

            check_call(
                [
                    '/usr/bin/env bash -c'
                    ' "polybar --config={polybar_config_location} --reload '
                    '{bar_config} & disown"'.format(
                        polybar_config_location=polybar_config_location,
                        bar_config=bar_config,
                    ),
                ],

                env=polybar_env,

                # This is needed as we need to pass & disown at the end...
                shell=True,

                # So that we don't get shite pumped to the terminal, send
                # everything to /dev/null
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )

    except CalledProcessError as err:
        LOG.exception('Failed to launch polybar instances: %s', err, exc_info=True)
        LOG.exception("StdOut: %s\n\nStdErr: %s", err.output, err.stderr)
        sys.exit(1)


if __name__ == '__main__':
    MONITOR_INFO = get_monitor_info()
    kill_polybar()
    launch_polybars(MONITOR_INFO)
    LOG.info('Polybars relaunched')
