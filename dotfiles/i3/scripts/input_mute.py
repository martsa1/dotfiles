#!/usr/bin/env python
"""Small util to toggle mute on all `pactl` inputs."""

from dataclasses import dataclass
import argparse
import typing as t
import subprocess as sp
import shlex
import sys
import json
from time import sleep


@dataclass
class Args:
    status: bool
    monitor: bool
    interval: float = 0.2


@dataclass
class Source:
    name: str
    description: str
    muted: bool


def get_sources() -> t.Iterator[Source]:
    cmd = "pactl -f json list sources"
    out = sp.run(shlex.split(cmd), text=True, check=True, stdout=sp.PIPE)

    sources_raw = json.loads(out.stdout)

    for source in sources_raw:
        name = source.get("name", "unknown")
        description = source.get("description", "unknown")
        muted = source.get("mute", "unknown")

        device_class = source.get("properties", {}).get("device.class")
        if device_class == "monitor":
            # print(f"Skipping monitor: {name}", file=sys.stderr)
            continue

        if any((name == "unknown", muted == "unknown")):
            # print("Skipping unknown source", file=sys.stderr)
            continue

        yield Source(name, description, muted)


def get_default_source() -> t.Optional[Source]:
    cmd = "pactl info"
    def_sink = "Default Source:"

    out = sp.run(shlex.split(cmd), text=True, check=True, stdout=sp.PIPE)
    dev_name: str = ""
    for line in out.stdout.splitlines():
        if line.startswith(def_sink):
            dev_name = line.split(def_sink)[-1].strip()
            break

    for device in get_sources():
        if device.name == dev_name:
            return device

    return None


def toggle_mute(source: Source) -> bool:
    cmd = "pactl set-source-mute {} toggle"
    sp.run(shlex.split(cmd.format(source.name)), check=True, text=True)

    return not source.muted


def status() -> None:
    default_source = get_default_source()
    if not default_source:
        sys.exit(1)

    if default_source.muted:
        print("MUTED")
    else:
        print("UNMUTED")



def parse_args() -> Args:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-s",
        "--status",
        action="store_true",
        help="return whether sources are mute, if not set, will toggle mute",
    )
    parser.add_argument(
        "-m",
        "--monitor",
        action="store_true",
        help="Emits Mute/Unmute status every <Interval> seconds (for polybar)",
    )
    parser.add_argument(
        "-i",
        "--interval",
        default="0.2",
        help="Intervale for monitor to poll at in seconds",
    )

    args = parser.parse_args()
    return Args(status=args.status, monitor=args.monitor, interval=args.interval)


def main() -> None:
    args = parse_args()

    if args.status:
        status()
        return

    if args.monitor:
        try:
            while True:
                sleep(float(args.interval))
                status()
        except KeyboardInterrupt:
            sys.exit()

    res: t.Optional[bool] = None
    for source in get_sources():
        res = toggle_mute(source)

    # if res is not None:
        # sp.run(["notify-send", "Muted" if res else "Unmuted"], check=False)


if __name__ == "__main__":
    main()
