# Reusable home-manager modules, exposed as the flake's `homeModules` output
# (parallel to `nixosModules`, which holds NixOS modules). Machines pull one in
# with `imports = [ outputs.homeModules.<name> ];` and then toggle it via
# `sm.<name>.enable`, matching the NixOS side. Modules MUST be inert when
# disabled (mkIf cfg.enable).
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
