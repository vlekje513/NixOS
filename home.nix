{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "vlekje";
  home.homeDirectory = "/home/vlekje";

  programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, brave"
          "$mod, T, exec, kitty"
          "$mod, U, exec, echo $XDG_SESSION_TYPE"
          "$mod, P, exit"
          ", Print, exec, grimblast copy area"
        ];
      };
  };

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    btop
    
  ];

  # basic configuration of git, please change to your own
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
