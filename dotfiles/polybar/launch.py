#!/usr/bin/env python3
"""
Simple module which will spawn polybar instances for primary and any secondary
monitors.
"""
import argparse
import logging
import os
import re
import signal
import shlex
import subprocess
import sys
from pathlib import Path
from typing import Optional

#  logging.basicConfig(level=logging.INFO)
logging.basicConfig(level=logging.DEBUG)
LOG = logging.getLogger("polybar-launcher")


def kill_polybar():
    """
    Terminates any instances of polybar using the `pkill` command.
    """
    try:
        LOG.info("Killing any existing polybar processes")
        polybar_instances = [
            int(pid) for pid in subprocess.check_output([
                "pgrep",
                "polybar",
            ]).decode().splitlines()
        ]

        polybar_instances = [pid for pid in polybar_instances if pid != os.getpid()]

        for pid in polybar_instances:
            os.kill(pid, signal.SIGTERM)

        LOG.debug("Old polybar terminated.")

    except subprocess.CalledProcessError:
        LOG.info("No Polybar instances found")


def get_monitor_info():
    """
    Retrieves monitor configuration from `xrandr`, processes it and returns a
    list of monitor information, providing monitors along with which monitor
    xrandr considers to be primary.
    """
    xrandr_locations = ["xrandr", "/run/current-system/sw/bin/xrandr"]
    monitor_info: Optional[str] = None
    for xrandr_binary in xrandr_locations:
        try:
            LOG.debug("Retrieving monitor information using '%s'.", xrandr_binary)
            monitor_info = subprocess.check_output([
                f"{xrandr_binary}",
                "--listactivemonitors",
            ])
            monitor_info = monitor_info.decode("utf-8")
            LOG.debug("Found monitors:\n%s", monitor_info)
            break

        except (subprocess.CalledProcessError, FileNotFoundError):
            LOG.info("Failed to retrieve monitor information with '%s'", xrandr_binary)

    if monitor_info is None:
        LOG.error("Failed to retrieve monitor information with any available binary.")
        sys.exit(1)

    monitor_info_regex = (
        r"^\s(?P<monitor_number>\d): \+(?P<primary>\*?)(?P<monitor_name>["
        r"a-zA-Z\d-]+) (?:\d+/\d+x\d+/\d+\+)(?P<horizontal_offset>\d{0,4})\+("
        r"?P<vertical_offset>\d{0,4})\s*(?:[a-zA-Z\d-]+)$"
    )

    monitors = []
    for line in monitor_info.split("\n"):
        LOG.debug("Checking line for monitor info:\n%s", line)

        monitor_info_match = re.search(monitor_info_regex, line)

        if monitor_info_match:
            LOG.debug("Found a matching monitor: %s", monitor_info_match)
            match_details = {
                "monitor_number": monitor_info_match.group("monitor_number"),
                "is_primary": bool(monitor_info_match.group("primary")),
                "monitor_name": monitor_info_match.group("monitor_name"),
                "horizontal_offset": (monitor_info_match.group("horizontal_offset")),
                "vertical_offset": monitor_info_match.group("vertical_offset")
            }
            LOG.debug("Match details:\n%s", match_details)

            monitors.append(match_details)
        else:
            LOG.debug("Line failed to match")

    return sorted(monitors, key=lambda x: x["monitor_number"])


def launch_polybars(list_of_monitors, echo_only=False):
    """
    Launches one or more instances of polybar.

    Requires a list of monitor information as provided by get_monitor_info.
    """
    polybar_config_location = Path(os.environ["HOME"], ".config", "polybar", "config")

    try:
        polybar_env = os.environ
        for monitor in list_of_monitors:
            polybar_env["MONITOR"] = monitor["monitor_name"]

            bar_config = ("primary" if monitor["is_primary"] else "secondary")

            LOG.debug("Launching Polybar instance '%s', primary: '%s'", monitor, bar_config)
            if not echo_only:
                cmd = f"polybar --config={polybar_config_location} --reload {bar_config}"

                LOG.debug("polybar command: '%s'", cmd)
                subprocess.Popen(
                    shlex.split(cmd),
                    env=polybar_env,

                    # So that we don't get shite pumped to the terminal, send
                    # everything to /dev/null
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                )

                LOG.debug("Polybar instance launched")

            else:
                env_str = " ".join(f"{key}={value}" for key, value in polybar_env.items())
                polybar_cmd = f"polybar --config={polybar_config_location} --reload {bar_config} &"

                # Using print here to return output to stdout, where logs print to stderr.
                print(f"{env_str} {polybar_cmd}")

        try:
            polybar_processes = [
                os.readlink(Path("/proc", pid, "exe"))
                for pid in subprocess.check_output(["pgrep", "polybar"]).decode().splitlines()
            ]
            LOG.info("Polybar processes post-launch: '%s'", "\n\t - ".join(polybar_processes))
        except (FileNotFoundError, subprocess.CalledProcessError):
            LOG.error("Couldn't run post-launch summary.")

    except subprocess.CalledProcessError as err:
        LOG.exception("Failed to launch polybar instances: %s", err, exc_info=True)
        LOG.exception("StdOut: %s\n\nStdErr: %s", err.output, err.stderr)
        sys.exit(1)


if __name__ == "__main__":
    ARGPARSER = argparse.ArgumentParser(description="re-launch polybar.")
    ARGPARSER.add_argument(
        "--echo-only",
        dest="echo_only",
        help="Print commands, don't execute them, defaults to executing",
        action="store_true",
    )
    ARGPARSER.add_argument(
        "--no-kill",
        dest="no_kill",
        help="Don't terminate existing instances if set.  Defaults to killing.",
        action="store_true",
    )
    ARGS = ARGPARSER.parse_args()

    LOG.debug("Re-launching polybar.")
    MONITOR_INFO = get_monitor_info()
    if not ARGS.no_kill:
        kill_polybar()

    launch_polybars(MONITOR_INFO, ARGS.echo_only)
    LOG.info("Polybars relaunched")
