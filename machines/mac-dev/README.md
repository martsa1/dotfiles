# Installation

## Darwin
Setup Nix with:
```
curl -L https://nixos.org/nix/install | sh -s -- --darwin-use-unencrypted-nix-store-volume  --no-daemon
```

Setup Nix-Darwin with:
```
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```

Run the initial build of nix-darwin with:
```
export MACHINE=mac-dev # Or whatever machine's config to load is.
darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/machines/MACHINE/configuration.nix
```
