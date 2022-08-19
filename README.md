# Installation

## Linux
Setup Nix (Ignore this step if running NixOS):
```
```

Pull in dotfiles:
```
nix-shell -p git
mkdir -p ~/.config
git clone --recursive https://github.com/ABitMoreDepth/dotfiles.git ~/.config/nixpkgs
```

Link the relevant machine to `home.nix`:
```
ln -s ~/.config/nixpkgs/machines/<system>/default.nix ~/.config/nixpkgs/home.nix

```

Pull in home-manager channel
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
# May need to add this to current shell (or re-login):
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
```
TODO: Pretty sure something somewhere said channels are deprecated...

Build initial home-manager generation:
```
nix-shell '<home-manager>' -A install
```

At this point, `home-manager` should be available in path, as usual.


## Darwin
Setup Nix with:
```
curl -L https://nixos.org/nix/install | sh -s -- --darwin-use-unencrypted-nix-store-volume  --no-daemon
```

Pull in dotfiles:
```
nix-shell -p git
mkdir -p ~/.config
git clone --recursive https://github.com/ABitMoreDepth/dotfiles.git ~/.config/nixpkgs
```

Setup Nix-Darwin with:
```
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```

Pull in Home-Manager Channel
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```
TODO: Pretty sure something somewhere said channels are deprecated...

Run the initial build of nix-darwin with:
```
export MACHINE=mac-dev # Or whatever machine's config to load is.
darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/machines/MACHINE/configuration.nix
```

Should be sorted.

