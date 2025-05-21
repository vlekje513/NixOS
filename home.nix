{ config, pkgs, inputs, ... }:

{
  home.username = "vlekje";
  home.homeDirectory = "/home/vlekje";

  # Hyprland configuration via home-manager
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland; # Can specify package here too, but system-level is also fine
    # For more complex configs, you can source a file:
    # extraConfig = builtins.readFile ./hyprland.conf;

    # Using the settings attribute as you were
    settings = {
      "$mod" = "SUPER"; # Use the let-defined variable

      # Recommended: Autostart XDG Desktop Portal for Hyprland if not handled by systemd user service
      # This is often better handled by a systemd user service or a wrapper script.
      # exec-once = "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"; # If using systemd user session
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # Propagate Wayland vars to D-Bus
        "systemctl --user start xdg-desktop-portal-hyprland" # Start the portal service for the user
        "systemctl --user start xdg-desktop-portal-gtk" # if needed
        "waybar" # Example: start Waybar if you use it
        "mako"   # Example: start notification daemon
      ];


      monitor = ",preferred,auto,1"; # Basic monitor config, adjust if needed

      input = {
        kb_layout = "us"; # Set your keyboard layout
        follow_mouse = 1;
        touchpad.natural_scroll = false;
        sensitivity = 0.0; # Default sensitivity
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle"; # or master
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      gestures = {
        workspace_swipe = true;
      };

      # Example window rule:
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

      bind = [
        "$mod, RETURN, exec, kitty" # Changed T to RETURN, common for terminal
        "$mod, F, exec, brave"
        "$mod, Q, killactive,"
        "$mod, M, exit," # Changed P to M for exit, P often used for other things
        "$mod, E, exec, thunar" # Example: file manager
        "$mod, V, togglefloating,"
        "$mod, P, pseudo," # dwindle
        "$mod, J, togglesplit," # dwindle

        # Move focus with mainMod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        # ... more workspaces

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        # ... more workspaces

        # Screenshots
        ", Print, exec, grimblast copy area" # Your existing screenshot bind
        "$mod, Print, exec, grimblast copy window"
        "SHIFT, Print, exec, grimblast copy output"
      ];
    };
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    btop
    grimblast
    waybar
    mako
    wlogout
    # thunar # GTK File manager
    # capitaine-cursors # Example cursor theme
    # hyprpicker # Color picker
  ];

  programs.kitty = {
    enable = true;
    # font.name = "Hack Nerd Font Mono"; # Example if you use Nerd Fonts
    # font.size = 11;
    # theme = "Catppuccin-Mocha"; # Example theme
    # settings = {
    #   scrollback_lines = 10000;
    #   enable_audio_bell = false;
    # };
  };

  programs.git = {
    enable = true;
    userName = "vlekje513";
    userEmail = "robbom2010@hotmail.com";
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
