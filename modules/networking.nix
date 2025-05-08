{ config, pkgs, ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  services.fail2ban = {
    enable = true;
    maxretry = 20;
  }
  services.openssh = {
    enable = true;
    authorizedKeys.keys = [
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5mLMzwlx+4FkB4q3dybESRH4uKYRCqVUNkZs/YL+Nj
    ];
  };
}
