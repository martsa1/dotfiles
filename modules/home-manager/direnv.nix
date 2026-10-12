/*
vim: set filetype=nix ts=2 sw=2 tw=0 et :
*/
# Sams direnv setup: direnv with zsh/bash integration and nix-direnv, plus the
# global direnvrc stdlib (per-project layout helpers: layout_poetry and
# use_uv-project). HM writes the stdlib to ~/.config/direnv/direnvrc -- the
# location direnv reads first; the legacy ~/.direnvrc is only a fallback. Like
# tmux this defaults to *on*: every machine wants direnv, so machines opt out
# with `sm.direnv.enable = false;`.
{
  config,
  lib,
  ...
}: let
  cfg = config.sm.direnv;
in {
  options.sm.direnv = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Whether to enable Sams direnv config. On by default; set to false to opt a machine out.";
    };
  };

  config = lib.mkIf cfg.enable {
    # stdlib (types.lines) rather than a bare xdg.configFile entry: this is the
    # option HM's direnv module provides for exactly this file, so it stays the
    # single writer of direnvrc and machines can append lines additively.
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
      stdlib = ''
        layout_poetry() {
            if [[ ! -f pyproject.toml ]]; then
                log_error 'No pyproject.toml found. Use `poetry new` or `poetry init` to create one first.'
                exit 2
            fi

            LOCK="$PWD/poetry.lock"
            watch_file "$LOCK"

            local VENV=$(poetry env info --path)
            if [[ -z $VENV || ! -d $VENV/bin ]]; then
                log_status 'No poetry virtual environment found. Running `poetry install` to create one.'
                poetry install
                VENV=$(poetry env info --path)
            else
                HASH="$PWD/.poetry.lock.sha512"
                if ! sha512sum -c $HASH --quiet >&/dev/null ; then
                    log_status 'poetry.lock has been updated. Running `poetry install`'
                    poetry install
                    sha512sum "$LOCK" > "$HASH"
                fi
            fi

            export VIRTUAL_ENV=$VENV
            export POETRY_ACTIVE=1
            PATH_add "$VENV/bin"
        }

        function use_uv-project() {
            source_up_if_exists

            source_env_if_exists .envrc.local
            LOCK="$PWD/uv.lock"
            watch_file "$LOCK"
            watch_file "pyproject.toml"

            uv sync --all-packages
            source .venv/bin/activate
        }
      '';
    };
  };
}
