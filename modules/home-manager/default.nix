# Reusable home-manager modules, exposed as the flake's `homeModules` output
# (parallel to `nixosModules`, which holds NixOS modules). Every module here is
# auto-injected into all homeConfigurations via the `mkHome` helper in
# flake.nix, so machines opt in with `sm.<name>.enable = true` and never need a
# per-machine import line. Modules MUST be inert when disabled (mkIf cfg.enable).
#
# A machine must NOT import these directly as well: the values here are
# functions rather than paths, so the module system cannot dedupe them and a
# second reference fails with "The option `sm.<name>.enable' ... is already
# declared".
#
# Most modules default to off and are opted into per machine. `tmux` is the
# exception: it defaults to on, so machines opt *out* with
# `sm.tmux.enable = false;`.
{
  aerospace = import ./aerospace.nix;
  i3-config = import ./i3-config.nix;
  ssh = import ./ssh.nix;
  tmux = import ./tmux.nix;
}
