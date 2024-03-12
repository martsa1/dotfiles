#!/usr/bin/env python
"""Small util to toggle mute on all `pactl` inputs."""

from dataclasses import dataclass
import typing as t
import subprocess as sp
import shlex
import json

@dataclass
class Source:
    name: str
    muted: bool


def get_sources() -> t.Iterator[Source]:
    cmd = "pactl -f json list sources"
    out = sp.run(shlex.split(cmd), text=True, check=True, stdout=sp.PIPE)

    sources_raw = json.loads(out.stdout)

    for source in sources_raw:
        name = source.get("name", "unknown")
        muted = source.get("mute", "unknown")

        device_class = source.get("properties", {}).get("device.class")
        if device_class == "monitor":
            print(f"Skipping monitor: {name}")
            continue

        if any((name == "unknown", muted == "unknown")):
            print("Skipping unknown source")
            continue

        yield Source(name, muted)


def toggle_mute(source: Source) -> None:
    cmd = "pactl set-source-mute {} toggle"
    sp.run(["notify-send", f"Toggling {source.name} from {source.muted}"], check=False)
    sp.run(shlex.split(cmd.format(source.name)), check=True, text=True)


def main() -> None:
    for source in get_sources():
        toggle_mute(source)


if __name__ == "__main__":
    main()
