"""Small utility to render I3 Jinja configurations, for use outside of ansible."""


from pathlib import Path
from os import environ

from jinja2 import Environment, FileSystemLoader


def main() -> None:
    base_config = Path(__file__).parent / "base_config"
    environment = Environment(
        loader=FileSystemLoader(base_config)
    )

    i3_config = environment.get_template("config.j2")

    user = environ.get("USERNAME", "sam")
    rendered_config = i3_config.render(user=user)

    print(rendered_config)


if __name__ == "__main__":
    main()
