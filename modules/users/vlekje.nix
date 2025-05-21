{ config, pkgs, ... }:

{

  #hardware.graphics = {
   # enable = true;
    #extraPackages = with pkgs; [
     # nvidia-vaapi-driver
    #];
  #};

  # hardware.nvidia.open = true;


  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    open-vm-tools
  ];

  services.dbus = {
    enable = true;
    implementation = "broker";
  };


  users.users.vlekje = {
    isNormalUser = true;
    description = "vlekje";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    packages = with pkgs; [
      vscode
      brave
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5mLMzwlx+4FkB4q3dybESRH4uKYRCqVUNkZs/YL+Nj"
    ];
  };
  
  virtualisation.vmware.guest = {
    enable = true;
    # autoResize = true; # Optional: if you want guest display to resize with window
  };

  fonts.packages = with pkgs; [
    # noto-fonts
    # noto-fonts-cjk-sans
    # noto-fonts-emoji
    font-awesome # Often used by bars/widgets
    # (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" ]; }) # Example Nerd Font
  ];

  environment.variables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland"; # Some apps might check this
    # MOZ_ENABLE_WAYLAND = "1"; # For Firefox, Brave (Chromium) usually auto-detects
    # QT_QPA_PLATFORM = "wayland;xcb"; # For Qt apps
    # SDL_VIDEODRIVER = "wayland";
    # CLUTTER_BACKEND = "wayland";
  };

  
}
