{inputs, config, ...}:
{
  nix-homebrew = {
    enable = true;

    user = "samuel";

    # Optional: Declarative tap management
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };

    mutableTaps = false;
  };

  # Homebrew setup
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = true;
    };

    casks = [
      "1password"  # Requires install into /Applications - impossible with nix
      "1password-cli"  # Requires install into /Applications - impossible with nix
      "tunnelblick"  # not packaged for nix
      "cloudflare-warp"  # nix package only includes CLI tools etc. not the server
      # "docker-desktop"  # not packaged for nix
      "meld"  # nixpkgs version seems messed up on mac.
      "teleport-connect"  # Not available via nix
    ];

    brews = [
      "falco"  # not packaged for nix yet
    ];

    taps = builtins.attrNames config.nix-homebrew.taps;
  };
}

