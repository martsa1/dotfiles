#!/usr/bin/env python3

from subprocess import check_output
import re


def main():
    ''' Simple process that greps the output from pactl to find the volume of
        the current sound device.
    '''
    sink_str = get_pactl_output()
    default_sink = sink_str.split('*')[-1]
    volume = re.search(r'^\s+volume:.+/\s+(\d{1,2}%).+$',
                       default_sink,
                       flags=re.MULTILINE)
    if volume:
        print(volume.group(1))


def get_pactl_output() -> str:
    '''Grabs the output from pactl ready for parsing
    '''
    sink_list = check_output([
        'pacmd',
        'list-sinks']).decode('ascii')
    return sink_list


if __name__ == '__main__':
    main()
