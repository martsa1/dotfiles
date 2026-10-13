{lib}:
lib.recursiveUpdate
(builtins.fromTOML (builtins.readFile ./starship.toml))
(builtins.fromTOML (builtins.readFile ./narrow.toml))
