{ config, pkgs, ... }:

{
  #services.xserver.enable = true;

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      # theme
    };
    displayManager.autoLogin = {
      enable = false;
      user = "vlekje";
    };
  };


  #services.desktopManager.plasma6.enable = true;

  console.keyMap = "us";

  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

  # services.printing.enable = true;

  # services.xserver.displayManager.autoLogin = {
  #   enable = false;
  #   user = "vlekje";
  # };
}
