{ ... }:

{
  imports = [
    ./linux_base
  ];

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "gb";
    options = [ "ctrl:nocaps" ];
  };
}
