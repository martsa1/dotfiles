# Used to bring all our modules into scope.
{ pkgs, python3, ...}:

{
  # awscli = pkgs.callPackage ./awscli { inherit pkgs; };
  polybar-launcher = pkgs.callPackage ./polybar-launcher { inherit pkgs; inherit python3; };
  polybar-spotify = pkgs.callPackage ./polybar-spotify { inherit pkgs; inherit python3; };
  i3-config = pkgs.callPackage ./i3-config { inherit pkgs; inherit python3; };
  dunst-dracula-theme = pkgs.callPackage ./dunst-dracula-theme { inherit pkgs; };
}
