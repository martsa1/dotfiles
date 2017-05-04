#!/usr/bin/env python3

import subprocess
# from subprocess import check_output


def main() -> str:
    ''' Simple process that greps the output from timetrap to return the
        current sheet and the time entry thats running on it.
    '''
    timesheet_info = get_timetrap_output()
    default_sink = timesheet_info.split('*')[-1].strip()

    if default_sink:
        print(default_sink)


def get_timetrap_output() -> str:
    '''Grabs the output from timetrap ready for parsing
    '''
    timesheet_info = subprocess.check_output(
        ['/usr/local/bin/t',
         'now'],
        stderr=subprocess.STDOUT).decode('ascii')
    return timesheet_info


if __name__ == '__main__':
    main()
