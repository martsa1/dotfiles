{ pkgs, ... }:

{
  imports = [
    ../linux_base
  ];

  home.packages = with pkgs; [
    ffmpeg
    globalprotect-openconnect
    openconnect
    remmina
    #rustdesk  - Seems broken at the moment.
    virt-manager
    vlc
  ];

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "gb";
    options = [ "ctrl:nocaps" ];
  };

  # Setup autorandr profiles
  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        "notify-i3" = "${pkgs.i3}/bin/i3-msg -s /run/user/1000/i3/ipc-socket.* restart && ${pkgs.systemd}/bin/systemctl --user restart polybar";
        "change-background" = "${pkgs.feh}/bin/feh --bg-scale ~/.background-image";
        "notify-user" = "${pkgs.libnotify}/bin/notify-send -i display 'Display profile changed:' $AUTORANDR_CURRENT_PROFILE";
       # "change-dpi" = ''
       #   case "$AUTORANDR_CURRENT_PROFILE" in
       #     default)
       #       DPI=120
       #       ;;
       #     home)
       #       DPI=192
       #       ;;
       #     work)
       #       DPI=144
       #       ;;
       #     *)
       #       echo "Unknown profle: $AUTORANDR_CURRENT_PROFILE"
       #       exit 1
       #   esac
       #   echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
       #'';
      };
    };
    profiles = {
      "default" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff004d10d01400000000031e0104b52215780ae668ab5035b8250c50540000000101010101010101010101010101010172e700a0f06045903020360050d21000001828b900a0f06045903020360050d210000018000000fe003930543032824c513135365231000000000002410332011200000b010a2020017502030f00e3058000e606050160602800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
        };
        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            #mode = "3840x2400";
            mode = "1920x1200";
            rate = "59.88";
            #rate = "59.99";
            #transform = [
            #  [ 0.5 0.0 0.0 ]
            #  [ 0.0 0.5 0.0 ]
            #  [ 0.0 0.0 1.0 ]
            #];
          };
          DP-1.enable = false;
          DP-2.enable = false;
          DP-3.enable = false;
        };
      };
    };
  };


  # Setup syncthing to pull over old machines stuff.
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };
}
