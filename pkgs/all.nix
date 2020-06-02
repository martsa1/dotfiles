# Used to bring all our modules into scope.
{ pkgs, python3, ...}:

{
  polybar-spotify = pkgs.callPackage ./polybar-spotify { inherit pkgs; inherit python3; };
  awscli = pkgs.callPackage ./awscli { inherit pkgs; };
}
