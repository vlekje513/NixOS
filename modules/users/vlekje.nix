{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia.open = true;
  programs.hyprland.enable = true;
  users.users.vlekje = {
    isNormalUser = true;
    description = "vlekje";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      vscode
      brave
    ];
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5mLMzwlx+4FkB4q3dybESRH4uKYRCqVUNkZs/YL+Nj"
    ];
  };
  
  virtualisation.vmware.guest = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    open-vm-tools
  ];
}
