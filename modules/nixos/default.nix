# Reusable NixOS modules, exposed as the flake's `nixosModules` output (parallel
# to `homeModules`, which holds home-manager modules). Every module here is
# auto-injected into all nixosConfigurations via the `mkNixos` helper in
# flake.nix, so hosts opt in with `sm.<name>.enable = true` and never need a
# per-host import line. Modules MUST be inert when disabled (mkIf cfg.enable).
{
  k3s = import ./k3s.nix;
  comin = import ./comin.nix;
}
