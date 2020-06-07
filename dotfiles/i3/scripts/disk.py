#!/usr/bin/env python3

from subprocess import check_output


def main():
    ''' Simple process that greps the output from pactl to find the volume of
        the current sound device.
    '''
    device_name, available_space = get_df_data()
    disk_util = get_iostat_output(device_name)
    if disk_util is not None:
        print('{} - {}%'.format(available_space, disk_util))
        if disk_util > 50:
            exit(33)
        exit(0)
    else:
        exit(1)




def get_df_data() -> str:
    ''' Grabs the name & available space of the device service the home
        directory
    '''
    df_output = check_output([
        'df',
        '-h',
        __file__
    ]).decode('ascii')

    df_segments = df_output.strip().split('\n')[-1].split('  ')
    available_space = df_segments[-2].strip()

    device_name = df_segments
    device_name = device_name[0].split('/')[-1].strip()

    return device_name, available_space


def get_iostat_output(device_name: str) -> str:
    '''Grabs the output from iostat ready for parsing
    '''
    iostat_output = check_output([
        'iostat',
        '-N',
        '-d',
        '-x',
        device_name]).decode('ascii')

    disk_util = int(float(iostat_output.split(' ')[-1].strip()))
    return disk_util


if __name__ == '__main__':
    main()


# '''
# DIR="${BLOCK_INSTANCE:-$HOME}"
# ALERT_LOW="${1:-10}" # color will turn red under this value (default: 10%)
#
# df -h -P -l "$DIR" | awk -v alert_low=$ALERT_LOW '
# /\/.*/ {
# 	# full text
# 	print $4
# 	# short text
# 	print $4
# 	use=$5
# 	# no need to continue parsing
# 	exit 0
# }
# END {
# 	gsub(/%$/,"",use)
# 	if (100 - use < alert_low) {
# 		# color
# 		print "#F92672"
# 	}
# }
# '
# '''
