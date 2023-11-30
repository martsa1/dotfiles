"""Small utility to render I3 Jinja configurations, for use outside of ansible."""


from pathlib import Path
from os import environ
import sys

from jinja2 import Environment, FileSystemLoader

def print_(msg: str) -> None:
    render_prefix = "render_i3_config:"
    print(f"{render_prefix} {msg}", file=sys.stderr, flush=True)


def main() -> None:
    base_config = Path(__file__).parent / "base_config"
    environment = Environment(
        loader=FileSystemLoader(base_config)
    )

    i3_config = environment.get_template("config.j2")

    user = environ.get("USERNAME", "sam")
    print_(f"Username: {user}")
    ansible_hostname = environ.get("HOSTNAME", "samlaptop")
    print_(f"Hostname: {ansible_hostname}")
    pactl = environ.get("PACTL")
    print_(f"{pactl=}")
    rendered_config = i3_config.render(user=user, ansible_hostname=ansible_hostname, pactl=pactl)

    print(rendered_config)


if __name__ == "__main__":
    main()
